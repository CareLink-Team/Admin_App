import 'package:admin_app/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/core/routing/routes.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case Routes.dashboard:
        return _adminRoute(const DashboardPage());

      case Routes.doctors:
        return _adminRoute(const DoctorsPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }

  static Route _adminRoute(Widget child) {
    return MaterialPageRoute(builder: (_) => AdminLayout(child: child));
  }
}
