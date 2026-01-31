import 'package:admin_app/core/routing/app_router.dart';
import 'package:admin_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // 1. Ensure Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Supabase (Using your service)
  await SupabaseService.initialize();

  // 3. Create instance and check if the user is already logged in
  final supabaseService = SupabaseService();
  final bool isLoggedIn = supabaseService.isLoggedIn;

  // 4. Pass the starting route to the App
  runApp(
    CareLinkAdminApp(
      initialRoute: isLoggedIn ? Routes.dashboard : Routes.login,
    ),
  );
}

class CareLinkAdminApp extends StatelessWidget {
  final String initialRoute;

  // Constructor now takes the starting route
  const CareLinkAdminApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareLink Admin',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,

      // Use the logic-driven route here
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
