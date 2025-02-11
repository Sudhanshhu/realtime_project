import 'package:flutter/material.dart';
import 'package:realtime_project/core/routing/app_routing.dart';
import 'package:realtime_project/core/routing/custom_args.dart';
import 'package:realtime_project/src/common/domain/models/employee.dart';

abstract class RouteManager {
  static void popTillHome(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.home));
  }

  static RouteSettings getEmpPgRs() {
    return const RouteSettings(name: AppRoutes.home);
  }

  static RouteSettings getAddEmpDetailsPgRs(Employee? employee) {
    return RouteSettings(
        name: AppRoutes.addEditEmployee,
        arguments: CustomArgs.defaultSetting(employee ?? Employee.empty()));
  }
}
