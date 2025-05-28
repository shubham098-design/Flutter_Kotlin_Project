import 'package:flutter/material.dart';

class ChannelPlaylistScreen extends StatefulWidget {
  const ChannelPlaylistScreen({super.key});

  @override
  State<ChannelPlaylistScreen> createState() => _ChannelPlaylistScreenState();
}

class _ChannelPlaylistScreenState extends State<ChannelPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
      ),
      child: Text("Playlist"),
    );
  }
}
