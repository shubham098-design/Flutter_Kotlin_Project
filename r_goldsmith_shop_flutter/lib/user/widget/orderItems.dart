import 'package:flutter/material.dart';

import '../../admine/models/product_model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.product, this.voidCallback});
  final Product product;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Card(
        elevation: 2,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.firstImageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 70,
                  ),
                ),
                SizedBox(width: 8), // 🔴 Added spacing
                Expanded(  // 🔴 Allow text to expand within available space
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180, // 🔴 Set max width for text
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black54,
                          ),
                          maxLines: 2, // 🔴 Allow up to 2 lines
                          overflow: TextOverflow.ellipsis, // 🔴 Show "..." if text is too long
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product.price,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
