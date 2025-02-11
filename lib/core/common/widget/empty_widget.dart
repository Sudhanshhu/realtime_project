import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/empty.jpeg',
        fit: BoxFit.cover,
        height: 200,
        width: 200,
      ),
    );
  }
}
