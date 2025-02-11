import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:realtime_project/core/common/styles/colors.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';
import 'package:realtime_project/core/extensions/date_time_ext.dart';
import 'package:realtime_project/core/extensions/string_ext.dart';
import 'package:realtime_project/src/common/domain/models/employee.dart';

class DisplayEmployee extends StatelessWidget {
  final Employee emp;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isCurrentEmployee;

  const DisplayEmployee({
    super.key,
    this.isCurrentEmployee = true,
    required this.emp,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              onDelete();
            },
            backgroundColor: AppColors.errorColor,
            foregroundColor: AppColors.whiteColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: KText(
          emp.name.formatName,
          fontSize: 16,
          isBold: true,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              emp.role?.title ?? "",
              color: AppColors.disabledColor,
            ),
            isCurrentEmployee
                ? KText(
                    "From ${emp.joiningDate?.todmmmyyyy() ?? ""} ",
                    color: AppColors.disabledColor,
                  )
                : KText(
                    "${emp.joiningDate?.todmmmyyyy()} - ${emp.leavingDate?.todmmmyyyy() ?? ""}",
                    color: AppColors.disabledColor,
                  ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
