import 'package:flutter/material.dart';

import '../../../utils/custom_drawer.dart';

class MobOrderScreen extends StatefulWidget {
  const MobOrderScreen({super.key});

  @override
  State<MobOrderScreen> createState() => _MobOrderScreenState();
}

class _MobOrderScreenState extends State<MobOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Orders Screen"),
      ),
    );
  }
}
