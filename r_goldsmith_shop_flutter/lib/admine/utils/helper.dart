

import 'dart:io';
import 'dart:math';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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

Future<File?> pickImageFromCamera() async{
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.camera);
  if(file == null){
    return null;
  }
  final dir = Directory.systemTemp;
  final targetPath = '${dir.absolute.path}/${uuid.v6()}.jpg';
  File image = await compressImage(File(file.path),targetPath);
  return image;
}