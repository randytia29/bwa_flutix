part of 'shared.dart';

Future<File?> getImage() async {
  try {
    ImagePicker _picker = ImagePicker();
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    File? file = await _cropImage(xFile!.path);

    return file;
  } catch (e) {
    print('getImage catch: $e');
    return null;
  }
}

Reference _reference = FirebaseStorage.instance.ref();

Future<File?> _cropImage(String sourcePath) async {
  File? file = await ImageCropper.cropImage(
      sourcePath: sourcePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 50,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Photo Cropper',
          statusBarColor: mainColor,
          activeControlsWidgetColor: mainColor),
      iosUiSettings: IOSUiSettings(title: 'Photo Cropper'));

  return file;
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
