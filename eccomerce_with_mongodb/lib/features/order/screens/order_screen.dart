import 'package:eccomerce_with_mongodb/features/order/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.orders.isEmpty
          ? const Center(child: Text("No Orders Available"))
          : ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) {
          final order = orderProvider.orders[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              title: Text("Order ID: ${order.id}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Amount: ₹${order.amount}",
                      style: const TextStyle(color: Colors.green, fontSize: 16)),
                  Text("Status: ${order.status}",
                      style: TextStyle(
                        color: order.status == "Delivered"
                            ? Colors.green
                            : order.status == "Pending"
                            ? Colors.orange
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Address: ${order.address.street}, ${order.address.city}",
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("Ordered on: ${order.createdAt.toLocal()}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              children: order.products.map((orderProduct) {
                final product = orderProduct.product;
                return ListTile(
                  leading: product.image.isNotEmpty
                      ? Image.network(product.image.first,
                      width: 70, height: 70,)
                      : const Icon(Icons.image_not_supported),
                  title: Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category: ${product.category}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      Text("Price: ₹${product.price}",
                          style: const TextStyle(color: Colors.green, fontSize: 14)),
                      Text("Quantity: ${orderProduct.quantity}",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
