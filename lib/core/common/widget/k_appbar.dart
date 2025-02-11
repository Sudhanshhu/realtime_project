import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/styles/colors.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final List<Widget> actionButtons;
  final PreferredSizeWidget? bottom;

  KAppBar({
    required this.title,
    this.bottom,
    this.actionButtons = const <Widget>[],
    super.key,
  }) : preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      bottom: bottom,
      backgroundColor: AppColors.primaryColor,
      elevation: 3,
      title: KText(
        title,
        fontSize: 16,
        color: AppColors.whiteColor,
      ),
      actions: actionButtons,
    );
  }
}
