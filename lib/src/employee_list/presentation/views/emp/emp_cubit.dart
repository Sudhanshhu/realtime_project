// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/routing/route_manager.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';

import 'package:realtime_project/src/employee_list/domain/repos/emp_repo.dart';
import 'package:realtime_project/src/employee_list/presentation/views/emp/emp_state.dart';

class EmpCubit extends Cubit<EmpState> {
  final EmployeeRepo repo;
  EmpCubit(
    this.repo,
  ) : super(const EmpState(isLoading: true));
  late BuildContext kContext;

  Future<void> loadInitialData(BuildContext context) async {
    kContext = context;
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final employees = await repo.getEmployees();
      emit(state.copyWith(employeeList: employees.data!, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> navigateToAddEmployee(Employee? emp) async {
    final rs = RouteManager.getAddEmpDetailsPgRs(emp);
    await Navigator.of(kContext).pushNamed(rs.name!, arguments: rs.arguments);

    loadInitialData(kContext);
  }
}
