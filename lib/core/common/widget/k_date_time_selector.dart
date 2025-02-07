// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/widget/k_textform_field.dart';

class KDateTimeSelector extends StatefulWidget {
  final String? hintText;
  final DateTime? selectedValue;
  final ValueChanged<DateTime?>? onSelected;
  const KDateTimeSelector({
    super.key,
    this.hintText,
    this.selectedValue,
    this.onSelected,
  });

  @override
  State<KDateTimeSelector> createState() => _KDateTimeSelectorState();
}

class _KDateTimeSelectorState extends State<KDateTimeSelector> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = widget.selectedValue?.toIso8601String() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KTextFormField(
      hintText: widget.hintText,
      readOnly: true,
      prefixIcon: const Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.selectedValue ?? DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101),
        );
        if (picked != null && widget.onSelected != null) {
          widget.onSelected!(picked);
          setState(() {
            dateController.text = picked.toIso8601String();
          });
        }
      },
      controller: dateController,
    );
  }
}
