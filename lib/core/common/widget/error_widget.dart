// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class KErrorWidget extends StatelessWidget {
  final String? msg;
  final String? retryText;
  final bool? showImage;
  final bool? retryTextBold;
  final String? appbarText;
  final VoidCallback? retry;

  const KErrorWidget({
    super.key,
    this.msg,
    this.retryText,
    this.showImage,
    this.retryTextBold,
    this.appbarText,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}
