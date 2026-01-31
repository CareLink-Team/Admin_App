import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize({
    String url = 'https://coxlqecyrfvmiqeomyqq.supabase.co',
    String anonKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNveGxxZWN5cmZ2bWlxZW9teXFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUwMDU2NTksImV4cCI6MjA4MDU4MTY1OX0.IRt22sRgFdJZiq2ZVaZJoSUSn8bY4tvcU2TnNfGDdW4',
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  Future<String?> getUserRole(String userId) async {
    final res = await client
        .from('user_profiles')
        .select('role')
        .eq('user_id', userId)
        .maybeSingle(); // 🔑 IMPORTANT

    if (res == null) return null;
    return res['role'] as String;
  }

  User? get currentUser => client.auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
