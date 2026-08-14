import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../screens/login/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/doctor/about_doctor_screen.dart';
import '../screens/appointment/appointment_confirmation_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String aboutDoctor = '/about_doctor';
  static const String confirmation = '/confirmation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case aboutDoctor:
        final doctor = settings.arguments as Doctor?;
        if (doctor == null) {
          return _errorRoute('Doctor profile details missing');
        }
        return MaterialPageRoute(
          builder: (_) => AboutDoctorScreen(doctor: doctor),
        );

      case confirmation:
        final args = settings.arguments as Map<String, dynamic>?;
        final doctor = args?['doctor'] as Doctor?;
        final selectedSlot = args?['selectedSlot'] as String? ?? 'Friday 10:30 AM';
        final selectedDate = args?['selectedDate'] as String? ?? 'June 19, 2025';

        if (doctor == null) {
          return _errorRoute('Appointment confirmation details missing');
        }
        return MaterialPageRoute(
          builder: (_) => AppointmentConfirmationScreen(
            doctor: doctor,
            selectedSlot: selectedSlot,
            selectedDate: selectedDate,
          ),
        );

      default:
        return _errorRoute('Page not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Navigation Error')),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
