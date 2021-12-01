import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username){
    FirebaseFirestore.instance.collection("users")
      .where("name",isEqualTo: username)
      .get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
      .add(userMap).catchError((e){
        print(e.toString());
      });
  }

}