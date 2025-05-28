import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key, required this.text, this.containerColor, this.textColor});
  final String text;
  final Color? containerColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      height: 25,
      decoration: BoxDecoration(
        color: containerColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1,color: Colors.black54)
      ),
      child: Center(child: Text(text,style: TextStyle(color: textColor ?? Colors.black),)),
    );
  }
}
