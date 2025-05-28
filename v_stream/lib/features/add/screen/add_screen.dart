import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_stream/features/add/controller/add_controller.dart';
import '../../../utlis/helper.dart';
import '../../auth/controller/auth_controller.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AuthController authController = Get.put(AuthController());
  AddController addController = Get.put(AddController());

  String selectedCategory = 'All'; // default value
  String selectVideoType = "video";

  final ImagePicker _picker = ImagePicker();
  XFile? _video;
  File? _thumbnail;

  Future<void> _pickVideo() async {
    // Pick a video from the gallery
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = pickedFile;
      });
    }
  }

  Future<void> _pickCameraVideo() async {
    // Pick a video from the camera
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _video = pickedFile;
      });
    }
  }

  Future<void> _pickImage() async {
    File? image = await pickImageFromGallery();
    if (image != null) {
      setState(() {
        _thumbnail = image;
      });
    }
  }


  void uploadVideo() {
    if (_video != null && _thumbnail != null && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      addController.uploadVideo(
        titleController.text,
        descriptionController.text,
        selectedCategory,
        "00:00",
        selectVideoType,
        File(_video!.path),
        File(_thumbnail!.path),
      );
    }else{
      Get.snackbar("Error", "All fields are required");
    }

  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Screen"),
      ),
      body: Obx(
            () => authController.isGettingUser.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: _thumbnail != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(
                          _thumbnail!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                          : const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image, color: Colors.blueAccent, size: 40),
                            SizedBox(height: 8),
                            Text(
                              "Pick Thumbnail",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _pickVideo,
                          borderRadius: BorderRadius.circular(12),
                          child: Card(
                            color: _video != null ? Colors.greenAccent.shade100 : Colors.lightBlueAccent.shade100,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _video != null ? Icons.check_circle_outline : Icons.video_library_outlined,
                                      size: 40,
                                      color: Colors.blueGrey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _video != null ? "Video Selected" : "Tap to pick a video",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Title",
                            labelText: "Title",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Description",
                  labelText: "Description",
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    child: (authController.userModel?.profilePic != null &&
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
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authController.userModel!.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(authController.userModel!.email),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              Text("Select Category", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: ['All', 'Entertainment', 'News', 'Comedy']
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              Text("Select Video Type", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectVideoType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectVideoType = newValue!;
                  });
                },
                items: ['video', 'short', 'post']
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Obx(
                  ()=> ElevatedButton.icon(
                    onPressed: () {
                      uploadVideo();
                    },
                    icon: const Icon(Icons.cloud_upload_rounded, color: Colors.white),
                    label: addController.isVideoUploading.value ? const CircularProgressIndicator()
                        : const Text(
                      "Upload",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Colors.blueAccent.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
