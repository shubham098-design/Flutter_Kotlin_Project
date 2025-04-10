import 'package:flutter/cupertino.dart';

class CustomTextView extends StatelessWidget {
  const CustomTextView({super.key, this.text, this.fontSize});

  final String? text;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
    );
  }
}
