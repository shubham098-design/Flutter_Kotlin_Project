import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/models/comment_model.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/image_circle.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/reply_card_top_bar.dart';

class ReplyCard extends StatelessWidget {
  final CommentModel replay;
  const ReplyCard({super.key,required this.replay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width*0.12,
              child: ImageCircle(
                url: replay.user?.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width*0.80,
              child: Column(
                children: [
                  ReplyCardTopBar(reply: replay),
                  Text(replay.reply!),
                ],
              ),
            )
          ],
        ),
        const Divider(color: Color(0xff242424)),
      ],
    );
  }
}
