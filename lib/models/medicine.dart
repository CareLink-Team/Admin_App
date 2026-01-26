class Medicine {
  final String id;
  final String name;
  final String? dosage_form;
  final String? strength;
  final String? created_at;

  Medicine({
    required this.id,
    required this.name,
    this.dosage_form,
    this.strength,
    this.created_at,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      dosage_form: json['dosage_form'],
      strength: json['strength'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'dosage_form': dosage_form,
    'strength': strength,
    'created_at': created_at,
  };
}
