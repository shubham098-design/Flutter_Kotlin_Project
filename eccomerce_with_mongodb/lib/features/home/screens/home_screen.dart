import 'package:eccomerce_with_mongodb/features/admine/screens/product_detail_screen.dart';
import 'package:eccomerce_with_mongodb/features/home/screens/home_product_detail_screen.dart';
import 'package:eccomerce_with_mongodb/features/home/services/home_service.dart';
import 'package:eccomerce_with_mongodb/features/search/screens/search_screen.dart';
import 'package:eccomerce_with_mongodb/models/product_model.dart';
import 'package:flutter/material.dart';

import 'category_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Image.asset("assets/images/amazon_in.png", height: 30),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width*0.6,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onSubmitted: navigateToSearchScreen,
                decoration: InputDecoration(
                  hintText: "Search Amazon.in",
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {

                    },
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerSlider(),
            const CategorySection(),
            const SizedBox(height: 10), // Fixed 1px spacing issue
            const ProductList(),
          ],
        ),
      ),
    );
  }
}


class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView(
        children: List.generate(
          2,
              (index) => Image.asset("assets/images/banner_${index + 1}.jpeg", fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {"name": "Mobile", "image": "assets/images/mobiles.jpeg"},
      {"name": "Essentials", "image": "assets/images/essentials.jpeg"},
      {"name": "Appliances", "image": "assets/images/appliances.jpeg"},
      {"name": "Electronics", "image": "assets/images/electronics.jpeg"},
      {"name": "Books", "image": "assets/images/books.jpeg"},
      {"name": "Fashion", "image": "assets/images/fashion.jpeg"},
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, CategoryDealsScreen.routeName, arguments: categories[index]['name']);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(categories[index]['image']!),
                  ),
                  const SizedBox(height: 5),
                  Text(categories[index]['name']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  HomeService homeService = HomeService();

  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  void fetchProducts() async{
    try{
      List<ProductModel> fetchedProducts = await homeService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    }catch(e){
      print("Error fetching products: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator())
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
    );
  }
}
