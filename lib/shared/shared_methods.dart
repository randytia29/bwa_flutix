part of 'shared.dart';

Future<File> getImage() async {
  ImagePicker _picker = ImagePicker();
  PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
  return File(pickedFile.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() => task);
  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String photoName) async {
  Reference ref = FirebaseStorage.instance.ref().child(photoName);
  return await ref.delete();
}
