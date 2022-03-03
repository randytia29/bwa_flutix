import 'dart:io';

import 'theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Reference _reference = FirebaseStorage.instance.ref();

Future<File?> getImage() async {
  final picker = ImagePicker();
  final xFile = await picker.pickImage(source: ImageSource.gallery);

  if (xFile != null) {
    final file = await _cropImage(xFile.path);

    return file;
  } else {
    return null;
  }
}

Future<File> _cropImage(String sourcePath) async {
  final cropper = ImageCropper();
  final file = await cropper.cropImage(
      sourcePath: sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 50,
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: accentColor1,
          toolbarWidgetColor: Colors.white,
          statusBarColor: accentColor1,
          activeControlsWidgetColor: mainColor),
      iosUiSettings: const IOSUiSettings(title: 'Photo Cropper'));

  if (file != null) {
    return file;
  } else {
    return File(sourcePath);
  }
}

// Future<Uint8List?> _compressImage(String path) async {
//   Uint8List? data =
//       await FlutterImageCompress.compressWithFile(path, quality: 50);

//   return data;
// }

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  UploadTask task = _reference.child(fileName).putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() => task);

  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String photoName) async {
  return await _reference.child(photoName).delete();
}
