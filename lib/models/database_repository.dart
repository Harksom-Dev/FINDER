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
  Future<List<User>> getUser() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    print(email);

    QuerySnapshot qshot = 
      await FirebaseFirestore.instance.collection(COLLECTION).where("email",isEqualTo: email).get();
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
    List<User> test = [];
    _firebaseFirestore.collection(COLLECTION).where("email",isNotEqualTo: 'user1');
    //_firebaseFirestore.collection(COLLECTION).doc('user1').collection('suggest').where("state",isNotEqualTo: 'hit').where("state",isNotEqualTo: 'pass').get();


  }

  @override
  Future<List<User>> usertoList() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    print(email);

    
    
    QuerySnapshot qshot = 
      await FirebaseFirestore.instance.collection(COLLECTION).where("email",isNotEqualTo: email).get();
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
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    await _firebaseFirestore.collection(COLLECTION).where("email",isEqualTo: email).get().then((snapshot){
      // print(snapshot.docs[0]['interested']);
      User.setInterested(snapshot.docs[0]['interested']);
    });
  }

  //getting an unlike and like of curent user and add to list in user model
  @override
  userLikedAndUnliked() async { 
    // String? email;
    // email = auth.FirebaseAuth.instance.currentUser?.email;
    // await _firebaseFirestore.collection(COLLECTION).where("email",isEqualTo: email).get().then((snapshot){
    //   // print(snapshot.docs[0]['interested']);
    //   User.setInterested(snapshot.docs[0]['like']);
    // });
    // await _firebaseFirestore.collection(COLLECTION).where("email",isEqualTo: email).get().then((snapshot){
    //   // print(snapshot.docs[0]['interested']);
    //   User.setInterested(snapshot.docs[0]['dislike']);
    // });
  }

  @override
  cleardislike() {
    // TODO: implement cleardislike
    throw UnimplementedError();
  }

  @override
  userLikedAndDisliked() {
    // TODO: implement userLikedAndDisliked
    throw UnimplementedError();
  }
  
}