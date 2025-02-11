import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/widget/k_calender.dart';
import 'package:realtime_project/core/common/widget/k_textform_field.dart';
import 'package:realtime_project/core/extensions/date_time_ext.dart';

class KDateTimeSelector extends StatefulWidget {
  final String? hintText;
  final DateTime? selectedValue;
  final ValueChanged<DateTime?>? onSelected;
  final bool nextmondayBtn;
  final bool nextTuesday;
  final bool after1WeekBtn;
  final bool todayBtn;
  final bool noDatebtn;
  const KDateTimeSelector({
    super.key,
    this.hintText,
    this.selectedValue,
    this.onSelected,
    this.nextmondayBtn = false,
    this.nextTuesday = false,
    this.after1WeekBtn = false,
    this.todayBtn = false,
    this.noDatebtn = false,
  });

  @override
  State<KDateTimeSelector> createState() => _KDateTimeSelectorState();
}

class _KDateTimeSelectorState extends State<KDateTimeSelector> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = widget.selectedValue?.todmmmyyyy() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KTextFormField(
      hintText: widget.hintText,
      readOnly: true,
      prefixIconData: Icons.calendar_today,
      onTap: () async {
        final pickedDate = await showDialog<DateTime?>(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          barrierLabel: "Select Date",
          useRootNavigator: true,
          builder: (_) => Center(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: MediaQuery.withClampedTextScaling(
                  maxScaleFactor: 1.1,
                  child: CustomCalendarDatePicker(
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 500)),
                    lastDate: DateTime.now().add(const Duration(days: 20)),
                    initialDate: DateTime.now(),
                    onDateChanged: (DateTime picked) {},
                    nextmondayBtn: widget.nextmondayBtn,
                    nextTuesday: widget.nextTuesday,
                    after1WeekBtn: widget.after1WeekBtn,
                    todayBtn: widget.todayBtn,
                    noDatebtn: widget.noDatebtn,
                  ),
                ),
              ),
            ),
          ),
        );
        if (pickedDate != null) {
          widget.onSelected!(pickedDate);
          setState(() {
            dateController.text = pickedDate.caption();
            dateController.selection = TextSelection.collapsed(
              offset: dateController.text.length,
            );
          });
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      controller: dateController,
    );
  }
}
