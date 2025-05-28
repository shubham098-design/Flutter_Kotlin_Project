import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/helper.dart';
import '../../auth/controller/auth_controller.dart';

class ChannelSetting extends StatefulWidget {
  const ChannelSetting({super.key});

  @override
  State<ChannelSetting> createState() => _ChannelSettingState();
}

class _ChannelSettingState extends State<ChannelSetting> {
  final AuthController authController = Get.put(AuthController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController channelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = authController.userModel?.username ?? "Name not found";
    phoneController.text = authController.userModel?.phone ?? "Phone not found";
    channelController.text = authController.userModel?.channelName ?? "Channel not found";
    descriptionController.text = authController.userModel?.channelDescription ?? "Description not found";
  }

  Future<void> _pickImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      authController.image.value = image;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Channel Setting"),
        centerTitle: true,
        actions: [
          Icon(Icons.search, size: 28),
          Icon(Icons.more_vert, size: 28),
        ],
      ),
      body: Obx(
        ()=> SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                child: authController.image.value != null
                    ? ClipOval(
                  child: Image.file(
                    authController.image.value!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
                    : (authController.userModel?.profilePic != null &&
                    authController.userModel!.profilePic!.isNotEmpty)
                    ? ClipOval(
                  child: Image.network(
                    authController.userModel!.profilePic!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(Icons.person, size: 50, color: Colors.grey.shade700),

              ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                ),
                readOnly: true,
                controller: TextEditingController(text: authController.userModel?.email ?? "Email not found"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'phone',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: channelController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:  "Channel ",
                ),

              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:"Description",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      authController.updateProfile(
                        nameController.text,
                        phoneController.text,
                        channelController.text,
                        descriptionController.text,
                        authController.image.value,
                      );
                    },
                    child: Text("Save", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
