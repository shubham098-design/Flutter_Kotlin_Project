
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile-screen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TextEditingController nameEditingController = TextEditingController(text: userProvider.user?.name ?? "No Name Available");
    TextEditingController emailEditingController = TextEditingController(text: userProvider.user?.email ?? "No Email Available");
    TextEditingController addressEditingController = TextEditingController(text: userProvider.user?.address ?? "No Address Available");

    void updateProfile() async {
      Map<String, dynamic> updatedData = {
        "name": nameEditingController.text,
        "email": emailEditingController.text,
        "address": addressEditingController.text,
      };
      await userProvider.updateUser(updatedData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: userProvider.isLoading ? Center(child: CircularProgressIndicator())
          :Column(
        children: [
          CustomTextField(textEditingController: nameEditingController, hintText: "Name", icon: Icons.person),
          CustomTextField(textEditingController: emailEditingController, hintText: "Email", icon: Icons.email),
          CustomTextField(textEditingController: addressEditingController, hintText: "Address", icon: Icons.location_on),
          ElevatedButton(
            onPressed: updateProfile,
            child: Text("Update Profile"),
          ),
        ],
      ),

    );
  }
}


class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.textEditingController, required this.hintText, required this.icon});
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          prefixIcon: Icon(icon),
        ),

      ),
    );
  }
}
