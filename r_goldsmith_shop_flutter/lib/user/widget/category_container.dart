import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key, required this.name, required this.imageUrl, this.voidCallback});

  final String name;
  final String imageUrl;
  final VoidCallback? voidCallback;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: voidCallback,
      child: Container(
        margin:EdgeInsets.symmetric(horizontal: 10),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.redAccent,width: 1)
        ),
        child: Center(
          child: Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset(imageUrl,fit: BoxFit.fill,)),
              Center(child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey))),
            ],
          ),
        ),
      ),
    );
  }
}