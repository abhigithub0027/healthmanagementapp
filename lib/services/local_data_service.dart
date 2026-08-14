import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/user.dart';
import '../models/doctor.dart';

class LocalDataService {
  final String usersPath;
  final String doctorsPath;

  LocalDataService({
    this.usersPath = 'assets/data/users.json',
    this.doctorsPath = 'assets/data/doctors.json',
  });

  /// Loads users from local JSON file
  Future<List<User>> loadUsers() async {
    try {
      final String jsonString = await rootBundle.loadString(usersPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load users data: $e');
    }
  }

  /// Loads doctor records from local JSON file
  Future<List<Doctor>> loadDoctors() async {
    try {
      final String jsonString = await rootBundle.loadString(doctorsPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((item) => Doctor.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load doctor catalog data: $e');
    }
  }
}
