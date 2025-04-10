import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce_with_mongodb/features/admine/services/admine_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product-details";

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel? product =
    ModalRoute.of(context)!.settings.arguments as ProductModel?;

    if (product == null) {
      return Scaffold(
        body: Center(child: Text("Product details not found!")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider for multiple images
            if (product.images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                ),
                items: product.images.map((imageUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error, size: 50, color: Colors.red),
                    ),
                  );
                }).toList(),
              ),

            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "\$${product.price}",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool success = await AdminServices().deleteProduct(product.id);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Product deleted successfully")),
                      );
                      Navigator.pop(context); // Delete hone ke baad wapas jana
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to delete product")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Delete Product"),
                ),
                ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("update"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


/***
 * image map concept by a example
 *
 * List<int> numbers = [1, 2, 3, 4, 5];
    List<int> squaredNumbers = numbers.map((num) => num * num).toList();

    print(squaredNumbers); // Output: [1, 4, 9, 16, 25]
 */