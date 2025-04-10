import 'package:flutter/material.dart';

class CustomDashboardTopContainer extends StatelessWidget {
  const CustomDashboardTopContainer({
    super.key,
    this.text,
    this.text2,
    this.icon,
    this.color,
  });

  final String? text;
  final String? text2;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color?.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(icon),
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(text!, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10,),
            Text("$text2", style: TextStyle(color: Colors.grey, fontSize: 20,fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}
