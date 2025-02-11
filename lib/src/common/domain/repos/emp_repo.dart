import 'package:realtime_project/core/models/api_response.dart';
import 'package:realtime_project/src/common/domain/models/employee.dart';

abstract class EmployeeRepo {
  EmployeeRepo();
  Future<ApiResponse<List<Employee>>> getEmployees();
  Future<ApiResponse<void>> addEmployee(Employee employee);
  Future<ApiResponse<void>> updateEmployee(Employee employee);
  Future<ApiResponse<void>> deleteEmployee(int id);
}
