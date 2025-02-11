// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:realtime_project/core/common/styles/colors.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool? isDisabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;

  const BaseButton({
    super.key,
    this.onPressed,
    this.title,
    this.isDisabled = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled! ? null : onPressed,
      splashColor: Colors.blue.withOpacity(0.3), // Custom splash color
      highlightColor: Colors.blue.withOpacity(0.1),
      child: Container(
        width: width,
        height: height ?? 38,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(child: Text(title ?? "", style: textStyle)),
        ),
      ),
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool isDisabled;
  final bool isSelected;
  final double? fontSize;
  final double? width;
  final double? height;
  final bool bold;
  final EdgeInsets? padding;

  const PrimaryBtn({
    super.key,
    this.onPressed,
    this.title,
    this.fontSize,
    this.width,
    this.height,
    this.isDisabled = false,
    this.bold = false,
    this.isSelected = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      padding: padding,
      width: width,
      height: height,
      onPressed: isDisabled ? null : onPressed,
      title: title,
      backgroundColor:
          isSelected ? AppColors.primaryColor : AppColors.secondaryTextColor,
      textStyle: TextStyle(
        color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
        fontSize: fontSize ?? 16,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class SecondaryBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool isDisabled;
  final double? fontSize;
  final bool bold;
  final EdgeInsets? padding;

  const SecondaryBtn({
    super.key,
    this.onPressed,
    this.title,
    this.fontSize,
    this.isDisabled = false,
    this.bold = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      padding: padding,
      onPressed: isDisabled ? null : onPressed,
      title: title,
      backgroundColor: AppColors.secondaryTextColor,
      textStyle: TextStyle(
        color: AppColors.primaryColor,
        fontSize: fontSize ?? 16,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class KIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final double size;
  final bool isDisabled;
  final String? tooltip;

  const KIconButton({
    super.key,
    this.onPressed,
    this.icon,
    this.color,
    this.size = 35,
    this.isDisabled = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isDisabled ? AppColors.disabledColor : color,
        size: size,
      ),
    );
  }
}
