import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:loginsystem/models/database_repository.dart';

class UploadPicture extends StatefulWidget {
  static const String routeName = '/uploadPicture';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => UploadPicture(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  _UploadPictureState createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  @override
  Widget build(BuildContext context) {
    ImagePicker _picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
        centerTitle: true,
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
        tooltip: 'Add Image',
        child: Icon(Icons.add),
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
          .putFile(File(image.path))
          .then((p0) => DatabaseRepository().updateUserPicture(image.name));
    } catch (_) {}
  }

  @override
  Future<String> getDownloadURL(String imageName) async {
    print('uploading to clound . . .');

    String downloadURL = await storage.ref('tempusers/$imageName').getDownloadURL();
    print('getDownloadURL');

    return downloadURL;
  }
}
