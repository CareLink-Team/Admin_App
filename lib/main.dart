import 'package:admin_app/core/routing/app_router.dart';
import 'package:admin_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const CareLinkAdminApp());
}

class CareLinkAdminApp extends StatelessWidget {
  const CareLinkAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: Routes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
