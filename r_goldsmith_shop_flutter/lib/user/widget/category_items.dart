import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  final String categoryName;
  final VoidCallback voidCallback;
  const CategoryItems({super.key,required this.categoryName,required this.voidCallback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        width: 90,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey,width: 2),
        ),
        child: Center(child: Text(categoryName,style: TextStyle(color: Colors.grey),)),
      ),
    );
  }
}