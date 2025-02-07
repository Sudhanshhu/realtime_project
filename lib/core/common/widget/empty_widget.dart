import 'package:flutter/material.dart';
import 'package:realtime_project/core/common/widget/k_appbar.dart';
import 'package:realtime_project/core/common/widget/ktext_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String? msg;
  final String? retryText;
  final bool showImage;
  final bool retryTextBold;
  final String? appbarText;
  final VoidCallback? retry;

  const EmptyWidget({
    this.msg,
    this.retry,
    this.retryText,
    this.appbarText,
    this.showImage = true,
    this.retryTextBold = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return appbarText == null
        ? _getBody()
        : Scaffold(
            appBar: KAppBar(title: appbarText!),
            body: _getBody(),
          );
  }

  Widget _getBody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: showImage ? 45 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          if (msg != null)
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: KText(
                msg!,
                fontSize: 20,
                textAlign: TextAlign.center,
              ),
            ),
          if (retry != null)
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh_outlined),
              label: KText(
                retryText ?? "Retry",
              ),
              onPressed: retry,
            ),
        ],
      ),
    );
  }
}
