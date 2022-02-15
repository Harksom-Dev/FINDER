import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/base_database_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class DatabaseRepository implements BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = 'tempusers'; //current collection use

  Future<List<User>> getUser() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    print(email);

    QuerySnapshot qshot = await FirebaseFirestore.instance
        .collection(COLLECTION)
        .where("email", isEqualTo: email)
        .get();
    return qshot.docs
        .map((doc) => User(
            id: doc['id'],
            name: doc['name'],
            age: doc['age'],
            imageUrls: doc['imageUrls'],
            bio: doc['bio'],
            interested: doc['interested'],
            email: doc['email'],))
        .toList();
  }

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
            email: doc['email'],))
        .toList();

    print(allData);
    return allData;
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    List<User> collectionData = await getAllDataFromCollection(COLLECTION);
    
    for (var doc in collectionData) {
        if (doc.email == email) {
          return doc;
        }
    }
    return null;
  }

  Future<void> updateUserPicture(String imageName) async {
    // String downloadUrl = await StorageRepository().getDownloadURL(imageName);
    // return _firebaseFirestore.collection('users').doc('user1').update({'imageUrls':FieldValue.arrayUnion([downloadUrl])});
  }

  Stream<List<User>> getAllUsers() {
    //trting to get all of users data collectiong from firebase and pass it to userfromSnapshot in user_model
    return _firebaseFirestore.collection('users').snapshots().map((snap) =>
        User.userfromSnapshot(
            snap)); //maybe use forloop for add a user in this snapshot
  }

  @override
  testdb() async {
    List<User> test = [];
    _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isNotEqualTo: 'user1');
    //_firebaseFirestore.collection(COLLECTION).doc('user1').collection('suggest').where("state",isNotEqualTo: 'hit').where("state",isNotEqualTo: 'pass').get();
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
            email: doc['email'],))
            
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

  //getting an unlike and like of curent user and add to list in user model
  @override
  userLikedAndUnliked() async {
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
  Future<List<List<int>>> getLikedAndUnlikedListByID(int id) async {
    List<int> like = [];
    List<int> disLike = [];

    List<User> collectionData = await getAllDataFromCollection(COLLECTION);

    for (var user in collectionData) {
      if (user.id == id) {
        
      }
    }
    return [like, disLike];
  }

  @override
  cleardislike() {
    // TODO: implement cleardislike
    // throw UnimplementedError();
  }

  @override
  userLikedAndDisliked() {
    // TODO: implement userLikedAndDisliked
    // throw UnimplementedError();
  }
}
