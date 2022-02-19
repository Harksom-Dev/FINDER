import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            top: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            right: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () async{
          ImagePicker _picker = ImagePicker();
          final XFile? _image =
              await _picker.pickImage(source: ImageSource.gallery);

          if (_image == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('No image was selected')));
          }
          if (_image != null) {
            print('Uploading . . . .');
            StoragePicture().uploadImage(_image);
          }
          },
          ),
        ),
      ),
    );
  }
}
class StoragePicture {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage
          .ref('image/${'user_1.jpg'}')
          .putFile(File(image.path));
          
    } catch (_) {}
  }

  @override
  Future<String> getDownloadURL(String imageName) async {
    print('uploading to clound . . .');

    String downloadURL = await storage.ref('user1/$imageName').getDownloadURL();
    print('getDownloadURL');

    return downloadURL;
  }
}