import 'package:flutter/material.dart';

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.4,
        height: MediaQuery.of(context).size.height*0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("No Playlist Video")),
            ),
            Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis,),
            Text(subtitle,style: TextStyle(color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
