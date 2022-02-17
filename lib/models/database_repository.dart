import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/base_database_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class DatabaseRepository implements BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = 'tempusers'; //current collection use


  @override
  Future<List<User>> getAllDataFromCollection(String collectionName) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(collectionName);
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => User(
              id: doc['id'],
              name: doc['name'],
              age: doc['age'],
              imageUrls: doc['imageUrls'],
              bio: doc['bio'],
              interested: doc['interested'],
              email: doc['email'],
              like: doc['like'],
              dislike: doc['dislike'],
            ))
        .toList();

    return allData;
  }

  @override
  Future<User?> getUserByEmail(String? email) async {
    List<User> collectionData = await getAllDataFromCollection(COLLECTION);

    for (var doc in collectionData) {
      if (doc.email == email) {
        return doc;
      }
    }
    return null;
  }

  @override
  Future<void> updateUserPicture(String imageName) async {
    // String downloadUrl = await StorageRepository().getDownloadURL(imageName);
    // return _firebaseFirestore.collection('users').doc('user1').update({'imageUrls':FieldValue.arrayUnion([downloadUrl])});
  }

  @override
  Future<List<User>> usertoList() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    print(email);

    QuerySnapshot qshot = await FirebaseFirestore.instance
        .collection(COLLECTION)
        .where("email", isNotEqualTo: email)
        .get();
    return qshot.docs
        .map((doc) => User(
              id: doc['id'],
              name: doc['name'],
              age: doc['age'],
              imageUrls: doc['imageUrls'],
              bio: doc['bio'],
              interested: doc['interested'],
              email: doc['email'],
              like: doc['like'],
              dislike: doc['dislike'],
            ))
        .toList();
  }

  @override
  userInterested() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    await _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isEqualTo: email)
        .get()
        .then((snapshot) {
      // print(snapshot.docs[0]['interested']);
      User.setInterested(snapshot.docs[0]['interested']);
    });
  }

  @override
  userLikedAndDisliked() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    await _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isEqualTo: email)
        .get()
        .then((snapshot) {
      // print(snapshot.docs[0]['interested']);
      User.setLiked(snapshot.docs[0]['like']);
    });
    await _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isEqualTo: email)
        .get()
        .then((snapshot) {
      // print(snapshot.docs[0]['interested']);
      User.setDisliked(snapshot.docs[0]['dislike']);
    });
  }

  @override
  Future<List<List<dynamic>>> getLikedAndUnlikedListByID(int id) async {
    List<dynamic> like = [];
    List<dynamic> disLike = [];

    List<User> collectionData = await getAllDataFromCollection(COLLECTION);

    for (var user in collectionData) {
      if (user.id == id) {
        like = user.like;
        disLike = user.dislike;
        break;
      }
    }
    return [like, disLike];
  }


  cleardislike() async{
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    QuerySnapshot snap = await _firebaseFirestore.collection(COLLECTION).where("email",isEqualTo: email).get();
    String curuser = snap.docs[0].id;
    _firebaseFirestore.collection(COLLECTION).doc(curuser).update({
      'dislike':[]
    });

    // _firebaseFirestore.collection('testupdate').doc('update').update({
    //   'dislike': []
    // });

    
  }


}
