import 'package:realtime_project/src/common/domain/models/employee.dart';

class EmpState {
  final bool isLoading;
  final String? error;
  final List<Employee> employeeList;

  const EmpState({
    this.isLoading = false,
    this.employeeList = const [],
    this.error,
  });

  EmpState copyWith({
    bool? isLoading,
    String? error,
    List<Employee>? employeeList,
  }) {
    return EmpState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      employeeList: employeeList ?? this.employeeList,
    );
  }
}
