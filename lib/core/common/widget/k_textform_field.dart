// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/styles/colors.dart';
import 'package:realtime_project/core/common/widget/k_icon.dart';

class KTextFormField extends StatelessWidget {
  const KTextFormField({
    super.key,
    this.validator,
    this.controller,
    this.filled = false,
    this.fillColour,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.valueText = "",
    this.prefixIconData,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.isEditable = true,
    this.isUnderLine = false,
    this.givePadding = true,
    this.isEnable = true,
    this.autofocus = false,
    this.onTap,
    this.disabledFillColor = Colors.black12,
    this.focusNode,
    this.mandatory = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String valueText;
  final IconData? prefixIconData;
  final int? minLines;
  final int? maxLines;
  final bool isEditable;
  final bool isUnderLine;
  final ValueChanged<String>? onChanged;
  final bool givePadding;
  final bool isEnable;
  final bool autofocus;
  final VoidCallback? onTap;
  final Color disabledFillColor;
  final FocusNode? focusNode;
  final bool mandatory;
  final double curve = 6.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(givePadding ? 8.0 : 0.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          maxWidth: 450,
        ),
        child: TextFormField(
          focusNode: focusNode,
          autofocus: autofocus,
          onTap: onTap,
          enabled: isEnable,
          onChanged: onChanged,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: validator ??
              ((mandatory && validator == null)
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return validator?.call(value);
                    }
                  : null),
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            prefixIcon:
                prefixIconData != null ? KIcon(icon: prefixIconData!) : null,
            hintText: hintText,
            label: Text(
              hintText ?? "",
              style: hintStyle ?? const TextStyle(color: AppColors.greyColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            // overwriting the default padding helps with that puffy look
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            filled: filled,
            fillColor: fillColour,
            suffixIcon: suffixIcon,

            hintStyle: hintStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}

typedef ValidatorFunction<T> = String? Function(T value);

String? commonValidator<T>({
  required String value,
  required List<ValidatorFunction<T>> rules,
  required T Function(String value) parser,
}) {
  try {
    T parsedValue = parser(value);
    for (var rule in rules) {
      String? result = rule(parsedValue);
      if (result != null) {
        return result;
      }
    }
  } catch (e) {
    return "Invalid input.";
  }
  return null;
}

String? stringValidator(
  String? value, {
  bool isMandatory = true,
  int minLength = 3,
  int maxLength = 100,
}) {
  if (value == null || value.isEmpty) {
    return "Value cannot be null.";
  }
  return commonValidator<String>(
    value: value,
    rules: [
      (v) => v.isEmpty ? "Cannot be empty." : null,
      (v) => v.length < minLength
          ? "Minimum $minLength characters required."
          : null,
    ],
    parser: (value) => value,
  );
}

String? intValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Value cannot be empty.";
  }
  return commonValidator<int>(
    value: value,
    rules: [
      (v) => v < 0 ? "Value must be non-negative." : null,
      (v) => v > 100 ? "Value cannot exceed 100." : null,
    ],
    parser: (value) => int.parse(value),
  );
}
