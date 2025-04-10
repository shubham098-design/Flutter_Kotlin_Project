import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.amber,
    )
  );
}

Future<List<File>> pickImages() async {
  final ImagePicker picker = ImagePicker();
  try {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      return images.map((image) => File(image.path)).toList();
    }
  } catch (e) {
    debugPrint("Error picking images: $e");
  }
  return [];
}