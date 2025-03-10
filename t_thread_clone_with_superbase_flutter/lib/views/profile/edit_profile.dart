import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/image_circle.dart';

import '../../controller/profile_controller.dart';
import '../../services/supabase_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController descriptionController = TextEditingController(text: "");
  final SupabaseServices supabaseServices = Get.find<SupabaseServices>();

  @override
  void initState() {
    if(supabaseServices.currentUser.value?.userMetadata?["description"] != null){
      descriptionController.text = supabaseServices.currentUser.value?.userMetadata?["description"];
    }
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          Obx(()=> TextButton(onPressed: () {
            profileController.updateProfile(supabaseServices.currentUser.value!.id, descriptionController.text);
                    }, child: profileController.loading.value ? SizedBox(width:14,height:14,child: CircularProgressIndicator()) : Text("Done")),
          )],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(()=> Stack(
                alignment: Alignment.topRight,
                children: [
                  ImageCircle(radius: 80,
                    file: profileController.image.value,
                    url: supabaseServices.currentUser.value?.userMetadata?["image"],
                  ),
                  IconButton(
                    onPressed: () {
                      profileController.pickImage();
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.white60,
                      child: Icon(Icons.edit, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Your Description",
                labelText: "Description",
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
