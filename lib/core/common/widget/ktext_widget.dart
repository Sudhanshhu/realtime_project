// ignore_for_file: public_member_api_docs, sort_constructors_first

// Make stateless widget which will take text as input and opyional design and return Text widget with that text.

import 'package:flutter/material.dart';

/// Text widget with black color as default color
class KText extends StatelessWidget {
  final String text;
  final bool isBold;
  final double fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;

  const KText(
    this.text, {
    this.textAlign,
    this.isBold = false,
    this.fontSize = 16,
    this.maxLines,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

kWhiteTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

kBlackTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

kGreyTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

kRedTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

kGreenTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}

kBlueTextStyle({bool isBold = false}) {
  return TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}
