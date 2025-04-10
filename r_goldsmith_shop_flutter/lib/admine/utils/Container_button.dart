import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({super.key, this.color, this.icon, this.text, this.textColor});

  final Color? color;
  final IconData? icon;
  final String? text;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey,width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: textColor,),
            Text( text!,style: TextStyle(color: textColor,fontSize: 15,decoration: TextDecoration.none),)
          ],
        ),
      ),
    );
  }
}
