part of 'shared.dart';

Future<File> getImage() async {
  ImagePicker _picker = ImagePicker();
  PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
  return File(pickedFile.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;
  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String photoName) async {
  StorageReference ref = FirebaseStorage.instance.ref().child(photoName);
  return await ref.delete();
}
