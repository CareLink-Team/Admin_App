import 'package:flutter_test/flutter_test.dart';
import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/models/caretaker.dart';
import 'package:admin_app/models/medicine.dart';

void main() {
  group('Doctor Model Test', () {
    test('fromJson and toJson', () {
      final json = {
        'doctor_id': '123',
        'specialization': 'Cardiology',
        'contact_number': '555-1234',
        'hospital_name': 'General Hospital',
      };

      final doctor = Doctor.fromJson(json);

      expect(doctor.doctor_id, '123');
      expect(doctor.specialization, 'Cardiology');
      expect(doctor.contact_number, '555-1234');
      expect(doctor.hospital_name, 'General Hospital');

      final newJson = doctor.toJson();
      expect(newJson, json);
    });
  });

  group('Caretaker Model Test', () {
    test('fromJson and toJson', () {
      final json = {
        'caretaker_id': '456',
        'age': 30,
        'gender': 'Male',
        'contact_number': '555-5678',
        'doctor_id': '123',
      };

      final caretaker = Caretaker.fromJson(json);

      expect(caretaker.caretaker_id, '456');
      expect(caretaker.age, 30);
      expect(caretaker.gender, 'Male');
      expect(caretaker.contact_number, '555-5678');
      expect(caretaker.doctor_id, '123');

      final newJson = caretaker.toJson();
      expect(newJson, json);
    });
  });

  group('Medicine Model Test', () {
    test('fromJson and toJson', () {
      final json = {
        'id': '789',
        'name': 'Aspirin',
        'dosage_form': 'Tablet',
        'strength': '500mg',
        'created_at': '2023-01-01T12:00:00Z',
      };

      final medicine = Medicine.fromJson(json);

      expect(medicine.id, '789');
      expect(medicine.name, 'Aspirin');
      expect(medicine.dosage_form, 'Tablet');
      expect(medicine.strength, '500mg');
      expect(medicine.created_at, '2023-01-01T12:00:00Z');

      final newJson = medicine.toJson();
      expect(newJson, json);
    });
  });
}
