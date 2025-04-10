import 'package:eccomerce_with_mongodb/features/home/screens/home_product_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../admine/screens/product_detail_screen.dart';
import '../services/search_services.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();
  List<ProductModel> _searchResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSearchResults();
  }

  void fetchSearchResults() async {
    try {
      List<ProductModel> results = await searchServices.searchProducts(widget.searchQuery);
      setState(() {
        _searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching search results: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for '${widget.searchQuery}'"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomeProductDetailScreen.routeName, arguments: product);
            },
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(product.description,maxLines: 2, overflow: TextOverflow.ellipsis),
              leading: product.images[0].isNotEmpty
                  ? Image.network(
                product.images[0],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.image_not_supported),
            ),
          );
        },
      ),
    );
  }
}
