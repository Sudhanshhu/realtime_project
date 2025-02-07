// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:realtime_project/core/role_enum.dart';

class Employee {
  final int id;
  final String name;
  final RoleEnum? role;
  final DateTime? joiningDate;
  final DateTime? leavingDate;
  Employee({
    required this.id,
    required this.name,
    this.role,
    this.joiningDate,
    this.leavingDate,
  });

  // empty employee
  static Employee empty() {
    return Employee(
      id: 0,
      name: '',
    );
  }

  Employee copyWith({
    int? id,
    String? name,
    RoleEnum? role,
    DateTime? joiningDate,
    DateTime? leavingDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      joiningDate: joiningDate ?? this.joiningDate,
      leavingDate: leavingDate ?? this.leavingDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role?.code,
      'joiningDate': joiningDate?.millisecondsSinceEpoch,
      'leavingDate': leavingDate?.millisecondsSinceEpoch,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      name: map['name'] as String,
      role: RoleEnum.fromCode(map['role'] as int),
      joiningDate: map['joiningDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['joiningDate'] as int)
          : null,
      leavingDate: map['leavingDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['leavingDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, role: $role, joiningDate: $joiningDate, leavingDate: $leavingDate)';
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.joiningDate == joiningDate &&
        other.leavingDate == leavingDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        joiningDate.hashCode ^
        leavingDate.hashCode;
  }
}
