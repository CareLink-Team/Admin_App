class Caretaker {
  final String caretaker_id;
  final int? age;
  final String? gender;
  final String? contact_number;
  final String? doctor_id;

  Caretaker({
    required this.caretaker_id,
    this.age,
    this.gender,
    this.contact_number,
    this.doctor_id,
  });

  factory Caretaker.fromJson(Map<String, dynamic> json) {
    return Caretaker(
      caretaker_id: json['caretaker_id'],
      age: json['age'],
      gender: json['gender'],
      contact_number: json['contact_number'],
      doctor_id: json['doctor_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'caretaker_id': caretaker_id,
    'age': age,
    'gender': gender,
    'contact_number': contact_number,
    'doctor_id': doctor_id,
  };
}
