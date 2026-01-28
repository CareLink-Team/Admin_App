import 'package:flutter/material.dart';
import '../../core/routing/routes.dart';
import '../../services/supabase_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SupabaseService _supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    _handleStartUp();
  }

  Future<void> _handleStartUp() async {
    // 1. Minimum delay for branding visibility
    await Future.delayed(const Duration(seconds: 2));

    // 2. Use your existing service logic
    final bool loggedIn = _supabaseService.isLoggedIn;

    if (!mounted) return;

    if (loggedIn) {
      // Optional: Check if the user is actually an admin
      final userId = _supabaseService.currentUser!.id;
      final role = await _supabaseService.getUserRole(userId);

      if (mounted) {
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        } else {
          // If logged in but not an admin, boot them back to login
          await _supabaseService.signOut();
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using the path that matches your lib structure
            Image.asset(
              'lib/assets/logos/carelink_logo.png',
              width: 200,
              // Error builder helps debug if the path is still wrong
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red, size: 50),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2D55A4)),
            ),
          ],
        ),
      ),
    );
  }
}
