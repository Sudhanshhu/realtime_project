import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/common/styles/colors.dart';

import 'package:realtime_project/core/common/widget/empty_widget.dart';
import 'package:realtime_project/core/common/widget/k_appbar.dart';
import 'package:realtime_project/core/common/widget/k_icon.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';
import 'package:realtime_project/core/di/di.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';
import 'package:realtime_project/src/employee_list/presentation/views/employee/emp_cubit.dart';
import 'package:realtime_project/src/employee_list/presentation/views/employee/emp_state.dart';
import 'package:realtime_project/src/employee_list/presentation/widgets/employee_tile.dart';

class EmployeHomeScreen extends StatefulWidget {
  const EmployeHomeScreen({super.key});

  @override
  State<EmployeHomeScreen> createState() => _EmployeHomeScreenState();
}

class _EmployeHomeScreenState extends State<EmployeHomeScreen> {
  final screenCubit = EmpCubit(di());

  @override
  void initState() {
    screenCubit.loadInitialData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: "Employee List"),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          screenCubit.navigateToAddEmployee(null);
        },
        child: const KIcon(
          icon: Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      body: BlocConsumer<EmpCubit, EmpState>(
        bloc: screenCubit,
        listener: (BuildContext context, EmpState state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, EmpState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(EmpState state) {
    final currentEmpList = state.employeeList
        .where((Employee e) => e.leavingDate == null)
        .toList();
    final previousEmpList = state.employeeList
        .where((Employee e) => e.leavingDate != null)
        .toList();
    return state.employeeList.isEmpty
        ? const EmptyWidget()
        : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentEmpList.isNotEmpty)
                  const ListTile(
                    title: KText(
                      "Employee List",
                      fontSize: 18,
                      isBold: true,
                      color: AppColors.primaryColor,
                    ),
                  ),
                if (currentEmpList.isNotEmpty)
                  Column(
                    children: currentEmpList
                        .map(
                          (emp) => DisplayEmployee(
                            emp: emp,
                            onTap: () {
                              screenCubit.navigateToAddEmployee(emp);
                            },
                            onDelete: () async {
                              await screenCubit.deleteEmployee(emp);
                            },
                          ),
                        )
                        .toList(),
                  ),
                if (previousEmpList.isNotEmpty)
                  const ListTile(
                    title: KText(
                      "Previous Employee",
                      fontSize: 18,
                      isBold: true,
                      color: AppColors.primaryColor,
                    ),
                  ),
                if (previousEmpList.isNotEmpty)
                  Column(
                    children: previousEmpList
                        .map(
                          (emp) => DisplayEmployee(
                            isCurrentEmployee: false,
                            emp: emp,
                            onDelete: () async {
                              await screenCubit.deleteEmployee(emp);
                            },
                            onTap: () {
                              screenCubit.navigateToAddEmployee(emp);
                            },
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          );
  }
}
