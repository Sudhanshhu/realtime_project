// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/common/widget/dropdown.dart';
import 'package:realtime_project/core/common/widget/k_cal_copy.dart';
import 'package:realtime_project/core/common/widget/k_date_time_selector.dart';

import 'package:realtime_project/core/common/widget/k_textform_field.dart';
import 'package:realtime_project/core/common/widget/toast.dart';
import 'package:realtime_project/core/di/di.dart';
import 'package:realtime_project/core/role_enum.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_cubit.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_state.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee employee;
  const AddEmployeeScreen({
    super.key,
    required this.employee,
  });

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final screenCubit = AddEmployeeCubit(di());

  @override
  void initState() {
    screenCubit.loadInitialData(widget.employee, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenCubit.pgTitle),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                screenCubit.onSavePressed(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        bloc: screenCubit,
        listener: (BuildContext context, AddEmployeeState state) {
          if (state.error != null) {
            showToasts(context, state.error!, isError: true);
          }
        },
        builder: (BuildContext context, AddEmployeeState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(AddEmployeeState state) {
    return Form(
      key: screenCubit.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            KTextFormField(
              controller: screenCubit.nameController,
              hintText: "Employee Name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              prefixIcon: const Icon(Icons.person),
            ),
            KdropDown<RoleEnum>(
              items: RoleEnum.values
                  .map(
                    (e) => SingleSelectionModel(
                      id: e.code.toString(),
                      object: e,
                      title: e.title,
                    ),
                  )
                  .toList(),
              hintText: "Select Role",
              onSelected: screenCubit.onRoleSelected,
              selectedValue: screenCubit.role,
              leadingWidget: const Icon(Icons.work),
            ),
            CalendarDatePickerCopy(
              firstDate: DateTime.now().subtract(const Duration(days: 500)),
              lastDate: DateTime.now().add(const Duration(days: 20)),
              initialDate: DateTime.now(),
              onDateChanged: (DateTime date) {
                print("Selected Date: $date");
              },
            ),
            IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    barrierLabel: "Select Date",
                    useRootNavigator: true,
                    builder: (_) => Center(
                      child: Dialog(
                        clipBehavior: Clip.antiAlias,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: MediaQuery.withClampedTextScaling(
                            maxScaleFactor: 1.3,
                            child: CalendarDatePickerCopy(
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 500)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 20)),
                              initialDate: DateTime.now(),
                              onDateChanged: (DateTime date) {
                                print("Selected Date: $date");
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month)),
            Row(
              children: [
                Expanded(
                  child: KDateTimeSelector(
                    key: const Key("fromDate"),
                    hintText: "Select Date of joining",
                    selectedValue: screenCubit.fromDate,
                    onSelected: screenCubit.onFromDateSelected,
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: KDateTimeSelector(
                    key: const Key("toDate"),
                    hintText: "Select Date of leaving",
                    selectedValue: screenCubit.toDate,
                    onSelected: screenCubit.onToDateSelected,
                  ),
                ),
              ],
            ),
            // const CustomCalendar(),
          ],
        ),
      ),
    );
  }
}
