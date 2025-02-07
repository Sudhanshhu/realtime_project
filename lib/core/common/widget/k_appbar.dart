import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final String? subTitle;
  final List<Widget> actionButtons;
  final PreferredSizeWidget? bottom;
  final bool visible;

  KAppBar({
    required this.title,
    this.subTitle,
    this.bottom,
    this.actionButtons = const <Widget>[],
    this.visible = true,
    super.key,
  }) : preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0),
        );

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return AppBar(toolbarHeight: 0);
    }
    return AppBar(
      bottom: bottom,
      leadingWidth: kToolbarHeight - 10,
      elevation: 3,
      title: subTitle == null
          ? KText(title, fontSize: 16, isBold: true)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(title, fontSize: 16, isBold: true),
                KText(subTitle!, fontSize: 13)
              ],
            ),
      actions: actionButtons,
    );
  }
}
