import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseUpdateMethods {
  getUserByEmail(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: username)
        .get();
  }

  uploadUserInfo(userMap) {
    print(userMap);
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print("failed to add user: $e");
    });
    print("database pushed");
  }

  updateUserInfo(userMap,String email)async {
    print(userMap);

    QuerySnapshot snap = await FirebaseFirestore.instance.collection('users')
    .where('email',isEqualTo: email)
    .get();

    String docID = snap.docs[0].id;

    FirebaseFirestore.instance.collection('users').doc(docID).update(userMap);
    // FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
    //   print("failed to add user: $e");
    // });
    // print("database pushed");
  }

  
}
