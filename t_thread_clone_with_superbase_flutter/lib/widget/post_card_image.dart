import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import '../utils/helper.dart';

class PostCardImage extends StatelessWidget {
  final String url;
  const PostCardImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          getCurrentUserS3Url(url),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
