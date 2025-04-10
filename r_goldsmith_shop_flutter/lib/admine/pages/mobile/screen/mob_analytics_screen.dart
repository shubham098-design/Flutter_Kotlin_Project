import 'package:flutter/material.dart';

import '../../../utils/custom_drawer.dart';

class MobAnalyticsScreen extends StatefulWidget {
  const MobAnalyticsScreen({super.key});

  @override
  State<MobAnalyticsScreen> createState() => _MobAnalyticsScreenState();
}

class _MobAnalyticsScreenState extends State<MobAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Analytics Screen"),
      ),
    );
  }
}
