class Doctor {
  final String doctorId;
  final String designation;
  final String department;
  final String? contactNumber;

  Doctor({
    required this.doctorId,
    required this.designation,
    required this.department,
    this.contactNumber,
  });

  /// From Supabase JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctor_id'] as String,
      designation: json['designation'] as String,
      department: json['department'] as String,
      contactNumber: json['contact_number'],
    );
  }

  /// To Supabase insert/update
  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'designation': designation,
      'department': department,
      'contact_number': contactNumber,
    };
  }
}
enum Department {
  cardiology,
  neurology,
  orthopedics,
  pediatrics,
  gynecology,
  generalMedicine,
  radiology,
}

extension DepartmentX on Department {
  String get label {
    switch (this) {
      case Department.cardiology:
        return 'Cardiology';
      case Department.neurology:
        return 'Neurology';
      case Department.orthopedics:
        return 'Orthopedics';
      case Department.pediatrics:
        return 'Pediatrics';
      case Department.gynecology:
        return 'Gynecology';
      case Department.generalMedicine:
        return 'General Medicine';
      case Department.radiology:
        return 'Radiology';
    }
  }
}
