import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/helper.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/type_def.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_card_bottombar.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_card_image.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_topbar.dart';

import '../models/post_model.dart';
import 'image_circle.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostCard({super.key, required this.post, this.isAuthCard = false,this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: ImageCircle(url: post.image),
              ),
              const SizedBox(width: 10),

              /// ✅ Wrapped with Expanded to prevent overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTopbar(post:post,isAuthCard: isAuthCard,callback: callback,),
                    /// Post Content
                    GestureDetector(
                        onTap: ()=>{
                          Get.toNamed(RouteName.showThread,arguments: post.id)
                        },
                        child: Text(post.content ?? "")),

                    const SizedBox(height: 10),

                    /// ✅ Image Handling with Constraints
                    if (post.image != null)
                      GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteName.showImage,arguments: post.image!);
                          },
                          child: PostCardImage(url: post.image!)),


                    PostCardBottombar(post: post)
                  ],
                ),
              )
            ],
          ),
          const Divider(color: Color(0xff242424)),
        ],
      ),
    );
  }
}
