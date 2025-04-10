import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CartProvider>().fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: cartProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : cartProvider.cartResponse?.cart.isEmpty ?? true
          ? Center(child: Text("No Items in Cart"))
          : ListView.builder(
        itemCount: cartProvider.cartResponse?.cart.length ?? 0,
        itemBuilder: (context, index) {
          final item = cartProvider.cartResponse!.cart[index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/home-product-details', arguments: item.product);
            },
            child: ListTile(
              leading: Image.network(item.product.image[0]),
              title: Text(item.product.name),
              subtitle: Text("₹${item.product.price} | Qty: ${item.quantity}"),
            ),
          );
        },
      ),
    );
  }
}
