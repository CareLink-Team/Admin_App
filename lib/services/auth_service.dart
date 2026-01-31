import 'package:admin_app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseService _supabase;

  AuthService(this._supabase);

  Future<User?> signInAdmin({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.signInWithEmailPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) return null;

    final role = await _supabase.getUserRole(user.id);

    if (role != 'admin') {
      await _supabase.signOut();
      throw AuthException('Access denied. Admins only.');
    }

    return user;
  }

  Future<void> signOut() => _supabase.signOut();
}
