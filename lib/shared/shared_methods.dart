part of 'shared.dart';

Future<File?> getImage() async {
  try {
    ImagePicker _picker = ImagePicker();
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

    return File(xFile!.path);
  } catch (e) {
    print('getImage catch: $e');
    return null;
  }
}

Future<String> uploadImage(File image) async {
  Uint8List? data =
      await FlutterImageCompress.compressWithFile(image.path, quality: 50);

  String fileName = basename(image.path);
  Reference ref = FirebaseStorage.instance.ref().child(fileName);

  UploadTask task = ref.putData(data!);

  TaskSnapshot snapshot = await task.whenComplete(() => task);
  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String photoName) async {
  Reference ref = FirebaseStorage.instance.ref().child(photoName);
  return await ref.delete();
}
