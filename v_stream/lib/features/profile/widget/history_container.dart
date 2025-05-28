import 'package:flutter/material.dart';

import '../../home/model/video_model.dart';

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({super.key, required this.video});

  final Video? video;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:  Image.network(video!.thumbnailUrl,fit: BoxFit.cover,),
              ),
            ),
            Text(video?.title ??"title",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis,),
            Text(video?.description ??"description",style: TextStyle(color: Colors.grey),maxLines: 1,overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
