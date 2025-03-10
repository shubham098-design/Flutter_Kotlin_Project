import 'package:flutter/material.dart';

import '../utils/type_def.dart';

class AuthInput extends StatelessWidget {
  final String hintText,label;
  final bool isPasswordField;
  final TextEditingController controller;
  final ValidatorCallback validator;
  const AuthInput({super.key,required this.hintText,required this.label,this.isPasswordField = false,required this.controller,required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey)
          ),
          prefixIcon: Icon(Icons.person),
          label: Text(label),
          hintText: hintText,
      ),
      obscureText: isPasswordField,
    );
  }
}
