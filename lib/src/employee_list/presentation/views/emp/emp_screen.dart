import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/common/widget/empty_widget.dart';
import 'package:realtime_project/core/common/widget/k_appbar.dart';
import 'package:realtime_project/core/di/di.dart';
import 'package:realtime_project/core/routing/route_manager.dart';
import 'package:realtime_project/src/employee_list/presentation/views/emp/emp_cubit.dart';
import 'package:realtime_project/src/employee_list/presentation/views/emp/emp_state.dart';

class EmployeHomeScreen extends StatefulWidget {
  const EmployeHomeScreen({super.key});

  @override
  _EmployeHomeScreenState createState() => _EmployeHomeScreenState();
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
        onPressed: () {
          screenCubit.navigateToAddEmployee(null);
        },
        child: const Icon(Icons.add),
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
    return state.employeeList.isEmpty
        ? const EmptyWidget(
            msg: "No employees found",
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              final emp = state.employeeList[index];
              return ListTile(
                title: Text(emp.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(emp.role?.title ?? ""),
                    Text(
                        "Joining Date: ${emp.joiningDate} - Leaving Date: ${emp.leavingDate}"),
                  ],
                ),
                onTap: () {
                  screenCubit.navigateToAddEmployee(emp);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.employeeList.length,
          );
  }
}
