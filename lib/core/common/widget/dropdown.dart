// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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

/// A dropdown widget that takes a list of [SingleSelectionModel] and returns the selected value.
///
/// {@tool snippet}
///
/// Use it as:
/// ```dart
/// GetDropDown<BusCityModel>(
///   leadingWidget: const Text("From City  : "),
///   optionsList: k2options,
///   selectedValue: selectedFromCityModel,
///   onSelected: (v) {
///     setState(() {
///       selectedFromCityModel = v;
///     });
///   },
///   hintText: "Select from City",
/// ),
/// ```
///
/// {@end-tool}
class KDropDown<T> extends StatelessWidget {
  final List<SingleSelectionModel> optionsList;
  final T? selectedValue;
  final ValueChanged<T?>? onSelected;
  final String? hintText;
  final String? labelText;
  final Widget? leadingWidget;
  final bool givePadding;

  const KDropDown({
    super.key,
    required this.optionsList,
    this.selectedValue,
    this.onSelected,
    this.hintText,
    this.labelText,
    this.leadingWidget,
    this.givePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(givePadding ? 8.0 : 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leadingWidget ?? Container(),
          if (leadingWidget != null) const SizedBox(width: 10),
          DropdownButton<T>(
            hint: Text(hintText ?? "hint N/A"),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            isExpanded: false,
            style: const TextStyle(color: Colors.black),
            value: selectedValue,
            items: optionsList
                .map((e) => DropdownMenuItem<T>(
                      value: e.object as T,
                      child: SizedBox(
                        width: 200,
                        child: ListTile(
                          title: Text(e.title),
                          subtitle:
                              e.subTitle != null ? Text(e.subTitle!) : null,
                          leading: e.leadingIcon,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (T? value) {
              if (value != null) {
                onSelected?.call(value);
              }
            },
          ),
        ],
      ),
    );
  }
}

class KdropDown<T> extends StatefulWidget {
  final List<SingleSelectionModel<T>> items;
  final T? selectedValue;
  final ValueChanged<T?>? onSelected;
  final String? hintText;
  final String? labelText;
  final Widget? leadingWidget;

  const KdropDown({
    super.key,
    required this.items,
    this.selectedValue,
    this.onSelected,
    this.hintText,
    this.labelText,
    this.leadingWidget,
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
      prefixIcon: widget.leadingWidget,
      suffixIcon: const Icon(Icons.arrow_drop_down),
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
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KText(
                          item.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    //     ListTile(
                    //   leading: item.leadingIcon,
                    //   title: Text(item.title),
                    //   subtitle:
                    //       item.subTitle != null ? Text(item.subTitle!) : null,
                    //   onTap: () {
                    //     // setState(() {
                    //     _controller.text = item.title;
                    //     _controller.selection = TextSelection.collapsed(
                    //         offset:
                    //             _controller.text.length); // Deselect all text

                    //     // });
                    //     widget.onSelected?.call(item.object);
                    //     Navigator.pop(context);
                    //   },
                    // );
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
