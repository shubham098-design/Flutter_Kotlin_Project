import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../cart/provider/cart_provider.dart';
import '../../order/provider/order_provider.dart';

class HomeProductDetailScreen extends StatefulWidget {
  static const String routeName = "/home-product-details";
  const HomeProductDetailScreen({super.key});

  @override
  State<HomeProductDetailScreen> createState() => _HomeProductDetailScreenState();
}

class _HomeProductDetailScreenState extends State<HomeProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final cartProvider = context.watch<CartProvider>();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    cartProvider.addToCart(product.id,);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Cart")));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  child: cartProvider.isAddingToCart ? CircularProgressIndicator() : Text("Add Cart"),
                ),
                ElevatedButton(onPressed: (){
                  orderProvider.placeOrder("67e3e95f2bc2d379646c58a3", [
                    {"productId": product.id, "quantity": 1}
                  ], product.price.toString(), "Shiva Mandir Road", "Muzaffarnagar", "251203");

                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  child: orderProvider.isPlacedOrderLoading ? CircularProgressIndicator()
                      : Text("Buy Now"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
