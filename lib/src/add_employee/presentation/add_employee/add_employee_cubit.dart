// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/common/widget/toast.dart';
import 'package:realtime_project/core/errors/exceptions.dart';

import 'package:realtime_project/core/role_enum.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_state.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';
import 'package:realtime_project/src/employee_list/domain/repos/emp_repo.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final EmployeeRepo repo;
  AddEmployeeCubit(
    this.repo,
  ) : super(const AddEmployeeState(isLoading: true));

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  RoleEnum? role;
  late Employee kEmployee;
  String pgTitle = "Add Employee Details";
  late BuildContext kContext;

  Future<void> loadInitialData(Employee employee, BuildContext context) async {
    final stableState = state;
    try {
      kContext = context;
      kEmployee = employee;
      nameController.text = employee.name;
      fromDate = employee.joiningDate;
      toDate = employee.leavingDate;
      role = employee.role;
      if (employee.id != 0) {
        pgTitle = "Edit Employee Details";
      }
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(isLoading: true));
      final employee = kEmployee.copyWith(
        name: nameController.text,
        joiningDate: fromDate,
        leavingDate: toDate,
        role: role,
        id: kEmployee.id == 0
            ? DateTime.now().millisecondsSinceEpoch
            : kEmployee.id,
      );
      try {
        final response = kEmployee.id == 0
            ? await repo.addEmployee(employee)
            : await repo.updateEmployee(employee);
        if (!response.success) {
          emit(state.copyWith(error: response.message));
          return;
        } else {
          emit(state.copyWith(isLoading: false, error: null));
          Navigator.of(context).pop();
        }
      } on CacheException catch (e) {
        showToasts(context, e.message, isError: true);
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        showToasts(context, "Something went wrong", isError: true);
        emit(state.copyWith(isLoading: false));
      }
    }
  }

  void onFromDateSelected(DateTime? date) {
    fromDate = date;
  }

  void onToDateSelected(DateTime? date) {
    toDate = date;
  }

  // dispose controllers
  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }

  void onRoleSelected(RoleEnum? value) {
    role = value;
  }
}
