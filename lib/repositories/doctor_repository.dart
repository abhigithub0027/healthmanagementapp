import '../models/doctor.dart';
import '../services/local_data_service.dart';

class DoctorRepository {
  final LocalDataService _dataService;

  DoctorRepository({LocalDataService? dataService})
      : _dataService = dataService ?? LocalDataService();

  /// Fetches all doctors from local JSON
  Future<List<Doctor>> getDoctors() async {
    return await _dataService.loadDoctors();
  }

  /// Filters doctors by in-network status or search term
  Future<List<Doctor>> getFilteredDoctors({
    bool? inNetworkOnly,
    String? searchQuery,
  }) async {
    final doctors = await getDoctors();
    return doctors.where((doc) {
      if (inNetworkOnly == true && !doc.inNetwork) {
        return false;
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchesName = doc.name.toLowerCase().contains(query);
        final matchesSpecialty = doc.specialty.toLowerCase().contains(query);
        final matchesHospital = doc.hospital.toLowerCase().contains(query);
        return matchesName || matchesSpecialty || matchesHospital;
      }
      return true;
    }).toList();
  }
}
