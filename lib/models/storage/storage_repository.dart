import 'package:image_picker/image_picker.dart';
import 'package:loginsystem/models/storage/base_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepository extends BaseStorageRepository{
  final firebase_storage.FirebaseStorage storage = 
  firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
  @override
  Future<String> getDownloadURL(String imageName) async {
     String downloadURL = await storage.ref('image/$imageName').getDownloadURL();

    return downloadURL;
  }


  
}