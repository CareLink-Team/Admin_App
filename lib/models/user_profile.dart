class UserProfile {
  final String userId;
  final String fullName;
  final String? email;
  final DateTime createdAt;
  final String role;

  UserProfile({
    required this.userId,
    required this.fullName,
    this.email,
    required this.createdAt,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      role: json['role'] as String,
    );
  }
}
