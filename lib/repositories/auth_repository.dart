import '../models/user.dart';
import '../services/local_data_service.dart';

class AuthRepository {
  final LocalDataService _dataService;

  AuthRepository({LocalDataService? dataService})
      : _dataService = dataService ?? LocalDataService();

  /// Validates user credentials against local JSON stored users
  Future<User?> authenticate(String username, String password) async {
    final users = await _dataService.loadUsers();
    final cleanUsername = username.trim().toLowerCase();

    for (final user in users) {
      if (user.username.trim().toLowerCase() == cleanUsername &&
          user.password == password) {
        return user;
      }
    }
    return null;
  }
}
