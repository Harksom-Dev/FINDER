import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/base_database_repository.dart';
import 'package:loginsystem/models/user_model.dart';



class DatabaseRepository extends BaseDatabaseRepository{
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = 'tempusers';   //current collection use
  @override
  Stream<User> getUser() { // get 1 user from firebase

    return _firebaseFirestore.collection('users')
            .doc('user1').snapshots().map((snap) => User.fromSnapshot(snap));
  }


  @override
  Future<void> updateUserPicture(String imageName) async {

    // String downloadUrl = await StorageRepository().getDownloadURL(imageName);
    // return _firebaseFirestore.collection('users').doc('user1').update({'imageUrls':FieldValue.arrayUnion([downloadUrl])});
  }

  @override
  Stream<List<User>> getAllUsers()  {    //trting to get all of users data collectiong from firebase and pass it to userfromSnapshot in user_model
    return _firebaseFirestore.collection('users').snapshots().map((snap) => User.userfromSnapshot(snap));    //maybe use forloop for add a user in this snapshot
  }

  @override
  testdb() async {
    return  FirebaseFirestore.instance.collection("users")
      .snapshots();

  }

  @override
  Future<List<User>> usertoList() async {
  QuerySnapshot qshot = 
      await FirebaseFirestore.instance.collection(COLLECTION).get();

    return qshot.docs.map(
        (doc) => User(
            id: doc['id'],
            name: doc['name'],
            age: doc['age'],
            imageUrls: doc['imageUrls'],
            bio: doc['bio'],
            interested: doc['interested'],
            email: doc['email']
            )
      ).toList();

  }

  @override
  userInterested() async {
    List<dynamic>? test = [];
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    await _firebaseFirestore.collection(COLLECTION).where("email",isEqualTo: email).get().then((snapshot){
      // print(snapshot.docs[0]['interested']);
      User.setInterested(snapshot.docs[0]['interested']);
    });

    
    




    
  }
  
}