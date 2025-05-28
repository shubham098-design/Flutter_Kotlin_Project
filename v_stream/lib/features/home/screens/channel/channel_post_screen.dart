import 'package:flutter/material.dart';

class ChannelPostScreen extends StatefulWidget {
  const ChannelPostScreen({super.key});

  @override
  State<ChannelPostScreen> createState() => _ChannelPostScreenState();
}

class _ChannelPostScreenState extends State<ChannelPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(

      ),
      child: Text("Post"),
    );
  }
}
