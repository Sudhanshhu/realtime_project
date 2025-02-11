import 'package:realtime_project/core/models/api_response.dart';
import 'package:realtime_project/src/common/data/datasources/local_ds.dart';
import 'package:realtime_project/src/common/domain/models/employee.dart';
import 'package:realtime_project/src/common/domain/repos/emp_repo.dart';

class EmpRepoImpl implements EmployeeRepo {
  final EmployeeLocalDs employeeLocalDs;
  EmpRepoImpl({required this.employeeLocalDs});
  @override
  Future<ApiResponse<void>> addEmployee(Employee employee) {
    try {
      final result = employeeLocalDs.addEmployee(employee);
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<ApiResponse<void>> deleteEmployee(int id) {
    try {
      final result = employeeLocalDs.deleteEmployee(id);
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<ApiResponse<List<Employee>>> getEmployees() {
    try {
      final result = employeeLocalDs.getEmployees();
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<ApiResponse<void>> updateEmployee(Employee employee) {
    try {
      final result = employeeLocalDs.updateEmployee(employee);
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }
}
