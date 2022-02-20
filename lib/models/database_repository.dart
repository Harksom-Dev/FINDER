import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/models/base_database_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class DatabaseRepository implements BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = 'users'; //current collection use

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
  getUser() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    QuerySnapshot snap = await _firebaseFirestore
        .collection(COLLECTION)
        .where('email', isEqualTo: email)
        .get();
    String docID = snap.docs[0].id;
    return _firebaseFirestore
        .collection(COLLECTION)
        .doc(docID)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPicture(String downloadUrl) async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    
    QuerySnapshot snap 
        = await _firebaseFirestore
            .collection(COLLECTION)
            .where('email',isEqualTo: email)
            .get();

    String docID = snap.docs[0].id;
    await _firebaseFirestore
          .collection(COLLECTION)
          .doc(docID)
          .update({
            'imageUrls':[downloadUrl,downloadUrl,downloadUrl]
          });
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

  cleardislike() async {
    String? email;
    email = auth.FirebaseAuth.instance.currentUser?.email;
    QuerySnapshot snap = await _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isEqualTo: email)
        .get();
    String curuser = snap.docs[0].id;

    _firebaseFirestore
        .collection(COLLECTION)
        .doc(curuser)
        .update({'dislike': []});

    // _firebaseFirestore.collection('testupdate').doc('update').update({
    //   'dislike': []
    // });
  }

  @override
  setRating(double rating, String ratedUser) async {
    int ratedid = 0;
    int currentid = 0;
    String uid; //temp for use when we re allocate id to uid
    await _firebaseFirestore
        .collection(COLLECTION)
        .where("email", isEqualTo: ratedUser)
        .get()
        .then((snapshot) {
      ratedid = snapshot.docs[0]['id'];
    });
    await _firebaseFirestore
        .collection(COLLECTION)
        .where("email",
            isEqualTo: auth.FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) {
      currentid = snapshot.docs[0]['id'];
    });
    QuerySnapshot snap = await _firebaseFirestore
        .collection('UserRating')
        .where("uid", isEqualTo: ratedid)
        .get();

    //first check if rating db already have current rating or not
    if (snap.docs.isEmpty) {
      Map<String, dynamic> rated = {"rating": rating, "uid": currentid};
      List<Map<String, dynamic>> ratingList = [rated];
      Map<String, dynamic> ratingInfoMap = {
        "uid": ratedid,
        "reviewby": ratingList
      };
      //if this empty we need to create new doc in db
      _firebaseFirestore.collection('UserRating').add(ratingInfoMap);
    } else {
      //if curent id have already create

      //get a list of collection
      List<dynamic> reviewbyList = [];
      await _firebaseFirestore
          .collection('UserRating')
          .where("uid", isEqualTo: ratedid)
          .get()
          .then((snapshot) {
        // print(snapshot.docs[0]['interested']);
        reviewbyList = snapshot.docs[0]['reviewby'];
      });
      // print(reviewbyList);
      //check if the current user is already rated it's or not ?
      bool isadd = false;
      for (int i = 0; i < reviewbyList.length; i++) {
        if (reviewbyList[i]['uid'] == currentid) {
          //if it's already have we need to add
          reviewbyList[i]['rating'] = rating;
          isadd = true;
        }
      }
      //if it's already create doc but not have a data in reviewby list we need to addit
      Map<String, dynamic> rated = {"rating": rating, "uid": currentid};
      if (!isadd) {
        reviewbyList.add(rated);
      }
      //update to firebase

      QuerySnapshot snap = await _firebaseFirestore
          .collection('UserRating')
          .where("uid", isEqualTo: ratedid)
          .get();
      String curuser = snap.docs[0].id;

      _firebaseFirestore
          .collection('UserRating')
          .doc(curuser)
          .update({'reviewby': reviewbyList});
    }
  }

  // backend for get current user rating
  //return an double of all rating
  Future<double> getUserRating() async {
    User? currentUser =
        await getUserByEmail(auth.FirebaseAuth.instance.currentUser!.email);
    var userid = currentUser?.id;

    List<dynamic> reviewbyList = [];
    await _firebaseFirestore
        .collection('UserRating')
        .where("uid", isEqualTo: userid)
        .get()
        .then((snapshot) {
      // print(snapshot.docs[0]['interested']);
      reviewbyList = snapshot.docs[0]['reviewby'];
    });
    double sum = 0;
    for (int i = 0; i < reviewbyList.length; i++) {
      // print(reviewbyList[i]['rating']);
      sum += reviewbyList[i]['rating'];
    }
    return sum / reviewbyList.length;
    print(sum / reviewbyList.length);
  }
}
