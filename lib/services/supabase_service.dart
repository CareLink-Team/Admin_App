import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  /// Gets the global Supabase client instance
  SupabaseClient get client => Supabase.instance.client;

  /// Initializes Supabase with the given [url] and [anonKey].
  /// This must be called before accessing any other Supabase functionality.
  static Future<void> initialize({
    required String url='https://coxlqecyrfvmiqeomyqq.supabase.co', 
    required String anonKey ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNveGxxZWN5cmZ2bWlxZW9teXFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUwMDU2NTksImV4cCI6MjA4MDU4MTY1OX0.IRt22sRgFdJZiq2ZVaZJoSUSn8bY4tvcU2TnNfGDdW4',
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  /// Returns the current authenticated user, or null if not signed in.
  User? get currentUser => client.auth.currentUser;

  /// Signs in a user with email and password.
  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
