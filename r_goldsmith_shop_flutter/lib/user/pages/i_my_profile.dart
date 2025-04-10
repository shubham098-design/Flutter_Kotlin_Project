import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../admine/utils/custom_text_field.dart';
import '../../admine/utils/custom_text_view.dart';
import '../controller/auth_controller.dart';
import 'dart:io';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    // Initialize controllers with default values (handle null safely)
    final TextEditingController nameController = TextEditingController(
      text: authController.user.value?.name ?? "",
    );
    final TextEditingController phoneController = TextEditingController(
      text: authController.user.value?.phone ?? "",
    );
    final TextEditingController addressController = TextEditingController(
      text: authController.user.value?.address ?? "",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(
            onPressed: () {
              authController.updateButton.value = true; // Toggle edit mode
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Obx(() {
        // Show loading indicator while fetching user data
        if (authController.getUserDataByLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // Profile Image
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.redAccent, width: 1),
                  ),
                  child: authController.updateButton.value
                      ? _buildEditableImage(authController)
                      : _buildDisplayImage(authController),
                ),
              ),

              const SizedBox(height: 20),

              // Profile Details
              _buildProfileFields(authController, nameController, phoneController, addressController),

              const SizedBox(height: 20),

              // Save Button (Only in Edit Mode)
              if (authController.updateButton.value)
                ElevatedButton(
                  onPressed: () async {
                    await _updateProfile(authController, nameController, phoneController, addressController);
                  },
                  child: const Text("Save Changes"),
                ),
            ],
          ),
        );
      }),
    );
  }

  /// Displays Profile Image
  Widget _buildDisplayImage(AuthController authController) {
    return authController.user.value?.imageUrl != null &&
        authController.user.value!.imageUrl!.isNotEmpty
        ? ClipRRect(
      borderRadius: BorderRadius.circular(75),
      child: Image.network(
        authController.user.value!.imageUrl!,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    )
        : const Center(child: Text("No image"));
  }

  /// Editable Profile Image (File Picker)
  Widget _buildEditableImage(AuthController authController) {
    return authController.image.value != null
        ? ClipRRect(
      borderRadius: BorderRadius.circular(75),
      child: Image.file(
        File(authController.image.value!.path),
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    )
        : IconButton(
      onPressed: () {
        authController.imagePick();
      },
      icon: const Icon(Icons.camera_alt, size: 50, color: Colors.red),
    );
  }

  /// Builds Profile Fields (Username, Email, Phone, Address)
  Widget _buildProfileFields(AuthController authController, TextEditingController nameController,
      TextEditingController phoneController, TextEditingController addressController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextView(text: "Username"),
        CustomTextField(
          controller: authController.updateButton.value ? nameController : null,
          hintText: authController.user.value?.name ?? "No Name",
        ),

        const SizedBox(height: 20),

        const CustomTextView(text: "Email"),
        CustomTextField(
          hintText: authController.user.value?.email ?? "No Email",
          // readOnly: true, // Email should not be editable
        ),

        const SizedBox(height: 20),

        const CustomTextView(text: "Phone"),
        CustomTextField(
          controller: authController.updateButton.value ? phoneController : null,
          hintText: authController.user.value?.phone ?? "No Phone",
        ),

        const SizedBox(height: 20),

        const CustomTextView(text: "Address"),
        CustomTextField(
          controller: authController.updateButton.value ? addressController : null,
          hintText: authController.user.value?.address ?? "No Address",
        ),
      ],
    );
  }

  /// Updates Profile and Handles Errors
  Future<void> _updateProfile(AuthController authController, TextEditingController nameController,
      TextEditingController phoneController, TextEditingController addressController) async {
    try {
      authController.updateProfileLoading.value = true;

      await authController.updateProfile(
        nameController.text.trim(),
        phoneController.text.trim(),
        addressController.text.trim(),
      );

      authController.updateButton.value = false; // Exit edit mode
      Get.snackbar("Success", "Profile updated successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (error) {
      Get.snackbar("Error", error.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      authController.updateProfileLoading.value = false;
    }
  }
}
