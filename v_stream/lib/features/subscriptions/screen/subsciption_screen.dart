import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubsciptionScreen extends StatefulWidget {
  const SubsciptionScreen({super.key});

  @override
  State<SubsciptionScreen> createState() => _SubsciptionScreenState();
}

class _SubsciptionScreenState extends State<SubsciptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.grey
      ),

    );
  }
}
