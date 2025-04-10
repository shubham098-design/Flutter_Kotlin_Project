import 'package:eccomerce_with_mongodb/constrants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        direction: Axis.horizontal,
        itemCount: 5,
        rating: rating,
        itemSize: 15,
        itemBuilder: (context,index){
      return const Icon(Icons.star, color: GlobalVariables.secondaryColor,);
    });
  }
}
