// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:realtime_project/core/common/styles/colors.dart';

class KIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;
  const KIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? AppColors.primaryColor,
      size: size ?? 20,
    );
  }
}
