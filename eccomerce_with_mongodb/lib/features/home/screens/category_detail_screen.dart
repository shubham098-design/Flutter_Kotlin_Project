import 'package:eccomerce_with_mongodb/features/home/services/home_service.dart';
import 'package:flutter/material.dart';

import '../../../constrants/global_variable.dart';
import '../../../models/product_model.dart';
import 'home_product_detail_screen.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {

  HomeService homeService = HomeService();
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    List<ProductModel> product = await homeService.fetchProductsByCategory(widget.category);
    setState(() {
      products = product;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, HomeProductDetailScreen.routeName, arguments: product);
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(product.images[0],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('\$${product.price}', style: const TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}