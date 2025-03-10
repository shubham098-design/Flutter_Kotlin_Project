import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../utils/helper.dart';
import '../utils/type_def.dart';

class PostTopbar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostTopbar({super.key,required this.post,required this.isAuthCard,this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            post.user!.metadata!.name!,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Wrap(
          spacing: 5,
          children: [
            Text(formatDate(post.createdAt!), style: TextStyle(color: Colors.grey)),
            isAuthCard ? GestureDetector(
              onTap: (){
                confirmDialog("Are you sure", "Once it is deleted, it cannot be recovered", (){
                  callback!(post.id!);
                });
              },
              child: const Icon(Icons.delete,color: Colors.red,),
            ) : Container(),
          ],
        ),
      ],
    );
  }
}
