import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/confirm_dialog.dart';
import 'package:uuid/uuid.dart';

import 'env.dart';

void showSnackBar( String title,String message,){
  Get.snackbar(title, message,
  snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    snackStyle: SnackStyle.GROUNDED,
    margin: const EdgeInsets.all(0),
    backgroundColor: Colors.black12
  );
}

// * Pick image from gallery

Future<File?> pickImageFromGallery() async{
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if(file == null){
    return null;
  }
  final dir = Directory.systemTemp;
  final targetPath = '${dir.absolute.path}/${uuid.v6()}.jpg';
  File image = await compressImage(File(file.path),targetPath);
  return image;

}

//* Compress image file

Future<File> compressImage(File image,String targetPath) async{
  var result = await FlutterImageCompress.compressAndGetFile(image.path, targetPath,quality: 70);
  return File(result!.path);
}

// * To get current user s3 url

String getCurrentUserS3Url(String path){
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";
}

// * Confirm dialog

void confirmDialog(String title , String text,VoidCallback callback){
  Get.dialog(ConfirmDialog(title: title,text: text,callback: callback,));
}

// * Format date

String formatDate(String date){

  // * Parse the Utc timestamp to datetime
  final DateTime utcDateTime = DateTime.parse(date.split("+")[0].trim());

  // * Convert UTC to IST
  final DateTime istDateTime = utcDateTime.add(const Duration(hours: 5,minutes: 30));

  // * Format the date
  return Jiffy.parseFromDateTime(istDateTime).fromNow();

}