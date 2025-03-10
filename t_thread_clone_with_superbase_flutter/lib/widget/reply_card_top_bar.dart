import 'package:flutter/material.dart';
import 'package:t_thread_clone_with_superbase_flutter/models/comment_model.dart';

import '../utils/helper.dart';

class ReplyCardTopBar extends StatelessWidget {
  final CommentModel reply;

  const ReplyCardTopBar({super.key,required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            reply.user!.metadata!.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Wrap(
          spacing: 5,
          children: [
            Text(formatDate(reply.createdAt!), style: TextStyle(color: Colors.grey)),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
