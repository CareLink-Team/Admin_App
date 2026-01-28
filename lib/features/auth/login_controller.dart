import 'package:flutter/material.dart';
import 'package:admin_app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends ChangeNotifier {
  final SupabaseService _supabase = SupabaseService();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await _supabase.signInWithEmailPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        _error = 'Invalid email or password';
        return false;
      }

      // 🔐 ROLE CHECK
      final role = await _supabase.getUserRole(user.id);

      if (role != 'admin') {
        await _supabase.signOut();
        _error = 'Access denied. Admins only.';
        return false;
      }

      return true;
    } on AuthException catch (e) {
      _error = e.message;
      return false;
    } catch (e) {
      _error = 'Something went wrong. Try again.';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
