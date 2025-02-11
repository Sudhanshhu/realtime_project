import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/widget/k_icon.dart';

import 'package:realtime_project/core/common/widget/k_textform_field.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';

class SingleSelectionModel<T> {
  final String id;
  final String title;
  final String? subTitle;
  final T object;
  Widget? leadingIcon;

  SingleSelectionModel({
    required this.title,
    required this.id,
    required this.object,
    this.subTitle,
    this.leadingIcon,
  });
}

class KdropDown<T> extends StatefulWidget {
  final List<SingleSelectionModel<T>> items;
  final T? selectedValue;
  final ValueChanged<T?>? onSelected;
  final String? hintText;
  final String? labelText;
  final IconData? leadingIcon;

  const KdropDown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onSelected,
    this.hintText,
    this.labelText,
    this.leadingIcon,
  });

  @override
  State<KdropDown<T>> createState() => _KdropDownState<T>();
}

class _KdropDownState<T> extends State<KdropDown<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.selectedValue != null) {
      final item = widget.items.firstWhere(
        (element) => element.object == widget.selectedValue,
        orElse: () => widget.items.first,
      );
      _controller.text = item.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KTextFormField(
      onTap: () => _showBottomSheet(context),
      hintText: widget.hintText,
      controller: _controller,
      readOnly: true,
      prefixIconData: widget.leadingIcon,
      suffixIcon: const KIcon(
        icon: Icons.arrow_drop_down,
        size: 35,
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.hintText ?? "Select an item",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return GestureDetector(
                      onTap: () {
                        _controller.text = item.title;
                        _controller.selection = TextSelection.collapsed(
                          offset: _controller.text.length,
                        );
                        widget.onSelected?.call(item.object);
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KText(
                          item.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
