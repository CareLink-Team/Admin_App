import 'package:admin_app/core/widgets/admin_layout.dart';
import 'package:admin_app/features/auth/login_controller.dart';
import 'package:admin_app/features/caretakers/caretakers_list.dart';
import 'package:admin_app/features/dashboard/dashboard_page.dart';
import 'package:admin_app/features/doctors/doctors_list.dart';
import 'package:admin_app/features/patients/patients_list.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/core/routing/routes.dart';
import 'package:provider/provider.dart';

import '../../features/auth/login_page.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => LoginController(),
            child: LoginPage(),
          ),
        );

      case Routes.dashboard:
        return _adminRoute(const DashboardPage(), title: 'Dashboard');

      case Routes.doctors:
        return _adminRoute(const DoctorsList(), title: 'Doctors');

      case Routes.patients:
        return _adminRoute(const PatientsList(), title: 'Patients');

      case Routes.caretakers:
        return _adminRoute(const CaretakersList(), title: 'Caretakers');

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }

  static Route _adminRoute(Widget child, {required String title}) {
    return MaterialPageRoute(
      builder: (_) => AdminLayout(title: title, child: child),
    );
  }
}
