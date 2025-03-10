import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/image_circle.dart';

import '../../controller/thread_controller.dart';
import '../../services/supabase_service.dart';
import '../../widget/add_thred_appbar.dart';
import '../../widget/thread_image_preview.dart';

class ThreadPage extends StatelessWidget {
   ThreadPage({super.key});
  final SupabaseServices supabaseServices = Get.find<SupabaseServices>();
  final ThreadController threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            AddThredAppbar(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=> ImageCircle(url: supabaseServices.currentUser.value!.userMetadata?["image"],)),
                SizedBox(width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(()=> Text(supabaseServices.currentUser.value!.userMetadata?["name"],),),
                    TextField(controller:threadController.textEditingController,onChanged: (value){
                      threadController.content.value = value;
                    },autofocus: true,
                      decoration: InputDecoration(border: InputBorder.none,hintText: "Start a thread..." ),
                      style: TextStyle(fontSize: 14),
                      maxLines: 10,
                      minLines: 1,
                      maxLength: 1000,
                    ),
                    GestureDetector(onTap:(){
                      threadController.pickImage();
                    },child: Icon(Icons.attach_file)),

                    Obx(()=> Column(
                      children: [
                        if(threadController.image.value != null)
                          ThreadImagePreview()
                      ],
                    ),
                    )
                  ],
                ),
                ),
              ],
            )


          ],
        ),
      )),
    );
  }
}
