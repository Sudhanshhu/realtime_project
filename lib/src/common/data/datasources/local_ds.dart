import 'dart:convert';

import 'package:realtime_project/core/errors/exceptions.dart';
import 'package:realtime_project/core/models/api_response.dart';
import 'package:realtime_project/src/common/domain/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EmployeeLocalDs {
  EmployeeLocalDs();
  Future<ApiResponse<void>> addEmployee(Employee employee);
  Future<ApiResponse<void>> deleteEmployee(int id);
  Future<ApiResponse<List<Employee>>> getEmployees();
  Future<ApiResponse<void>> updateEmployee(Employee employee);
}

class EmployeeLocalDsImpl implements EmployeeLocalDs {
  final SharedPreferences sharedPreferences;
  EmployeeLocalDsImpl({required this.sharedPreferences});
  static const String employeeKey = 'employee';

  Future<List<Employee>> getEmployeesFromSharedPref() async {
    final employee = sharedPreferences.getString(employeeKey);
    if (employee != null) {
      final data = jsonDecode(employee);
      if (data is List) {
        return data.map((e) => Employee.fromMap(e)).toList();
      }
      return [];
    } else {
      return [];
    }
  }

  @override
  Future<ApiResponse<void>> addEmployee(Employee employee) async {
    try {
      // final clear = await sharedPreferences.clear();
      List<Employee> empList = await getEmployeesFromSharedPref();
      empList.add(employee);
      List<Map<String, dynamic>> empMapList =
          empList.map((e) => e.toMap()).toList();
      await sharedPreferences.setString(employeeKey, jsonEncode(empMapList));
      return ApiResponse.success(null);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: '');
    }
  }

  @override
  Future<ApiResponse<void>> deleteEmployee(int id) async {
    try {
      List<Employee> empList = await getEmployeesFromSharedPref();
      empList.removeWhere((element) => element.id == id);
      List<Map<String, dynamic>> empMapList =
          empList.map((e) => e.toMap()).toList();
      await sharedPreferences.setString(employeeKey, jsonEncode(empMapList));
      return ApiResponse.success(null);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: '');
    }
  }

  @override
  Future<ApiResponse<List<Employee>>> getEmployees() async {
    try {
      final empList = await getEmployeesFromSharedPref();
      return ApiResponse.success(empList);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: '');
    }
  }

  @override
  Future<ApiResponse<void>> updateEmployee(Employee employee) async {
    try {
      List<Employee> empList = await getEmployeesFromSharedPref();
      empList.removeWhere((element) => element.id == employee.id);
      empList.add(employee);
      List<Map<String, dynamic>> empMapList =
          empList.map((e) => e.toMap()).toList();
      await sharedPreferences.setString(employeeKey, jsonEncode(empMapList));
      return ApiResponse.success(null);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: '');
    }
  }
}
