import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../admine/models/product_model.dart';

class ExploreLatestContainer extends StatelessWidget {
  const ExploreLatestContainer({super.key, required this.product, this.voidCallback});

  final VoidCallback? voidCallback;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    product.firstImageUrl,
                    width: 150,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline, color: Colors.red,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5), // Add spacing to prevent tight fit
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 15,),
            ),
            Text(
              "Rs.${product.price}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
