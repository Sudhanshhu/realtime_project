// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/buttons/primary_btns.dart';
import 'package:realtime_project/src/add_employee/presentation/add_employee/add_employee_cubit.dart';

class AddEmpoyeeBootomBtn extends StatelessWidget {
  const AddEmpoyeeBootomBtn({
    super.key,
    required this.screenCubit,
  });

  final AddEmployeeCubit screenCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, right: 24),
            // padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SecondaryBtn(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: "Cancel",
                  ),
                ),
                PrimaryBtn(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  onPressed: () {
                    screenCubit.onSavePressed(context);
                  },
                  title: "Save",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






        // padding: EdgeInsets.only(
        //   bottom: MediaQuery.of(context).viewInsets.bottom,
        // ),