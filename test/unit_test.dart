import 'package:flutter_test/flutter_test.dart';
import 'package:healthmanagmentsystem/models/user.dart';
import 'package:healthmanagmentsystem/models/doctor.dart';

void main() {
  group('User Model Tests', () {
    test('User.fromJson correctly parses valid user JSON', () {
      final jsonMap = {
        'username': 'test@example.com',
        'password': '123456',
        'name': 'Alex Johnson'
      };
      final user = User.fromJson(jsonMap);

      expect(user.username, 'test@example.com');
      expect(user.password, '123456');
      expect(user.name, 'Alex Johnson');
    });

    test('User.toJson outputs expected Map', () {
      const user = User(username: 'test@example.com', password: '123456', name: 'Alex Johnson');
      final jsonMap = user.toJson();

      expect(jsonMap['username'], 'test@example.com');
      expect(jsonMap['password'], '123456');
      expect(jsonMap['name'], 'Alex Johnson');
    });
  });

  group('Doctor Model Tests', () {
    test('Doctor.fromJson correctly parses doctor JSON payload', () {
      final jsonMap = {
        'id': 'doc_1',
        'name': 'Dr. Anjali Rao, MD',
        'specialty': 'Cardiology & Internal Medicine',
        'experience': '15+ Yrs Exp.',
        'rating': 4.9,
        'reviewCount': 142,
        'image': 'assets/images/doctor_1.png',
        'location': '1221 Health Plaza, Suite 400',
        'distance': '1.2 km',
        'hospital': 'HealthBridge Medical Center',
        'about': 'Board-certified internist...',
        'education': 'MD - Johns Hopkins',
        'consultationFee': 240.0,
        'insuranceCoverage': 240.0,
        'inNetwork': true,
        'nextSlot': 'Available this Friday at 10:30 AM',
        'phone': '+1 (555) 123-4567',
        'insuranceProviders': ['BLUE CROSS', 'AETNA GOLD'],
        'availableSlots': {
          'MON OCT 23': ['09:00 AM', '10:30 AM']
        }
      };

      final doctor = Doctor.fromJson(jsonMap);

      expect(doctor.id, 'doc_1');
      expect(doctor.name, 'Dr. Anjali Rao, MD');
      expect(doctor.rating, 4.9);
      expect(doctor.inNetwork, isTrue);
      expect(doctor.insuranceProviders.length, 2);
      expect(doctor.availableSlots.containsKey('MON OCT 23'), isTrue);
    });
  });
}
