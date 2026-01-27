class Patient {
  final String patient_id;
  final String age;
  final String gender;
  final String contact;
  final String address;
  final String medical_condition;
  final String doctor_id;
  final String caretaker_id;

  Patient({
    required this.patient_id,
    required this.age,
    required this.gender,
    required this.contact,
    required this.address,
    required this.medical_condition,
    required this.doctor_id,
    required this.caretaker_id,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patient_id: json['patient_id'],
      age: json['age'],
      gender: json['gender'],
      contact: json['contact'],
      address: json['address'],
      medical_condition: json['medical_condition'],
      doctor_id: json['doctor_id'],
      caretaker_id: json['caretaker_id'],
    );
  }
  Map<String, dynamic> toJson() => {
    'patient_id': patient_id,
    'age': age,
    'gender': gender,
    'contact': contact,
    'address': address,
    'medical_condition': medical_condition,
    'doctor_id': doctor_id,
    'caretaker_id': caretaker_id,
  };
}
