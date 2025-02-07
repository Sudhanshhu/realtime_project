import 'package:flutter/material.dart';
import 'package:realtime_project/core/routing/app_routing.dart';
import 'package:realtime_project/core/routing/custom_args.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_screen.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';
import 'package:realtime_project/src/employee_list/presentation/views/emp/emp_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final rsArgs =
      (settings.arguments != null) ? settings.arguments as CustomArgs : null;

  switch (settings.name) {
    case AppRoutes.home:
      return _pageBuilder((context) => const EmployeHomeScreen(),
          settings: settings);
    case AppRoutes.addEditEmployee:
      final Employee employee = rsArgs?.args as Employee;
      return _pageBuilder(
          (context) => AddEmployeeScreen(
                employee: employee,
              ),
          settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => const EmployeHomeScreen());
  }
}

PageRouteBuilder<T> _pageBuilder<T>(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder<T>(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
