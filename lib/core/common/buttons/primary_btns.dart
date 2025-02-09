// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:realtime_project/core/common/styles/colors.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool? isLoading;
  final bool? isDisabled;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? leading;
  final Widget? trailing;
  final bool? isOutlined;
  final bool? isElevated;
  final bool? isIconOnly;
  final bool? isIconLeading;
  final bool? isIconTrailing;
  final bool? isIconCenter;

  const BaseButton({
    super.key,
    this.onPressed,
    this.title,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.leading,
    this.trailing,
    this.isOutlined,
    this.isElevated,
    this.isIconOnly,
    this.isIconLeading,
    this.isIconTrailing,
    this.isIconCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color ?? Colors.blue),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
          ),
        ),
        // style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all<Color>(color!),
        // shape: RoundedRectangleBorder(
        //   borderRadius: borderRadius!,
        // ),

        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (isIconLeading == true) leading!,
            if (isIconCenter == true) leading!,
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
            if (trailing != null) const SizedBox(width: 10),
            if (isIconTrailing == true) trailing!,
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final bool? isLoading;
  final Widget? leading;
  final Widget? trailing;

  const PrimaryBtn({
    super.key,
    this.onPressed,
    this.title,
    this.isLoading,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      title: title,
      isLoading: isLoading,
      color: Colors.blue,
      textColor: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: leading,
      trailing: trailing,
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
    this.size = 40,
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
