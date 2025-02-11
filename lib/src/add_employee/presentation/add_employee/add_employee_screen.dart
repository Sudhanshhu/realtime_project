// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_project/core/common/styles/colors.dart';
import 'package:realtime_project/core/common/widget/dropdown.dart';
import 'package:realtime_project/core/common/widget/k_appbar.dart';
import 'package:realtime_project/core/common/widget/k_date_time_selector.dart';
import 'package:realtime_project/core/common/widget/k_icon.dart';

import 'package:realtime_project/core/common/widget/k_textform_field.dart';
import 'package:realtime_project/core/common/widget/toast.dart';
import 'package:realtime_project/core/di/di.dart';
import 'package:realtime_project/core/role_enum.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_cubit.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_state.dart';
import 'package:realtime_project/src/add_employee/presentation/widget/add_employee_bottom_btn.dart';
import 'package:realtime_project/src/employee_list/domain/models/employee.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee employee;
  const AddEmployeeScreen({
    super.key,
    required this.employee,
  });

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
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
      backgroundColor: AppColors.scaffoldbgColor,
      resizeToAvoidBottomInset: false,
      appBar: KAppBar(
        title: screenCubit.pgTitle,
      ),
      bottomNavigationBar: AddEmpoyeeBootomBtn(screenCubit: screenCubit),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: screenCubit.formKey,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              empNameWidget(),
              roleDropDown(),
              dateSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Row dateSelector() {
    return Row(
      children: [
        Expanded(
          child: KDateTimeSelector(
              todayBtn: true,
              nextmondayBtn: true,
              nextTuesday: true,
              after1WeekBtn: true,
              key: const Key("fromDate"),
              hintText: screenCubit.fromDate == null ? "No date" : "",
              selectedValue: screenCubit.fromDate,
              onSelected: (date) {
                screenCubit.onFromDateSelected(date);
                FocusScope.of(context).unfocus();
              }),
        ),
        const KIcon(icon: Icons.arrow_forward),
        Expanded(
          child: KDateTimeSelector(
              noDatebtn: true,
              todayBtn: true,
              key: const Key("toDate"),
              hintText: screenCubit.toDate == null ? "No date" : "",
              selectedValue: screenCubit.toDate,
              onSelected: (val) {
                screenCubit.onToDateSelected(val);
                FocusScope.of(context).unfocus();
              }),
        ),
      ],
    );
  }

  KdropDown<RoleEnum> roleDropDown() {
    return KdropDown<RoleEnum>(
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
      onSelected: (value) {
        screenCubit.onRoleSelected(value);
        FocusScope.of(context).unfocus();
      },
      selectedValue: screenCubit.role,
      leadingIcon: Icons.work_outline,
    );
  }

  KTextFormField empNameWidget() {
    return KTextFormField(
      controller: screenCubit.nameController,
      hintText: "Employee Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      prefixIconData: Icons.person_outline_rounded,
    );
  }
}
