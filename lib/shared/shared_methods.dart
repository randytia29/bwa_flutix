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

Reference reference = FirebaseStorage.instance.ref();

Future<String> uploadImage(File image) async {
  Uint8List? data =
      await FlutterImageCompress.compressWithFile(image.path, quality: 50);

  String fileName = basename(image.path);

  UploadTask task = reference.child(fileName).putData(data!);

  TaskSnapshot snapshot = await task.whenComplete(() => task);
  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String photoName) async {
  return await reference.child(photoName).delete();
}
