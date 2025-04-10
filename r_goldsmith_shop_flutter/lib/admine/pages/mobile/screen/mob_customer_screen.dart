import 'package:flutter/material.dart';
import 'package:r_goldsmith_shop_flutter/admine/utils/custom_drawer.dart';

class MobCustomerScreen extends StatefulWidget {
  const MobCustomerScreen({super.key});

  @override
  State<MobCustomerScreen> createState() => _MobCustomerScreenState();
}

class _MobCustomerScreenState extends State<MobCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Customer Screen"),
      ),
    );
  }
}
