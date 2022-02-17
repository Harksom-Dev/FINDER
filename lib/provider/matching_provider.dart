

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/database_repository.dart';
import '../models/user_model.dart';

class MatchingProvider {

  final _databaseRepository = DatabaseRepository();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = "MatchedData";

  Future<void> checkMatchByEmail(
      String cerentUserEmail, String userWhoGotLikedEmail) async {
    var tempCurrenUser = 
        _databaseRepository.getUserByEmail(cerentUserEmail);
    var tempUserWhoGotLiked =
        _databaseRepository.getUserByEmail(userWhoGotLikedEmail);
    User? currentUser = await tempCurrenUser;
    User? userWhoGotLiked = await tempUserWhoGotLiked;

    List<List> likeAndDisLikeList = await _databaseRepository
        .getLikedAndUnlikedListByID(userWhoGotLiked!.id);

    // likeAndDisLikeList index 0 is likeList and index 1 is dislikeList
    List likeList = likeAndDisLikeList[0];

    if (likeList.contains(currentUser!.id)) {
      print(currentUser.name + " match with " + userWhoGotLiked.name);
      addMatchedUserToMatchedData(currentUser, userWhoGotLiked);
      addMatchedUserToMatchedData(userWhoGotLiked, currentUser);
    } else {
      print(currentUser.name + " not match with " + userWhoGotLiked.name);
    }
  }
  
  Future<void> addMatchedUserToMatchedData(User currentUser, User user) async {
    
    //TODO: need to change to UID
    int currentUserID = currentUser.id;
    int userID = user.id;


    await _firebaseFirestore
        .collection(COLLECTION)
        .where("id", isEqualTo: currentUser.id)
        .get()
        .then((snapshot) async {
        
          if (snapshot.docs.isEmpty) {
            // if dont have any object contains id = currentUser.id
            // it will create new doc and field to collection

            Map<String, dynamic> dataForCurrentUser = {
              "id": currentUserID,
              "matchWith": [userID],
            };

            _firebaseFirestore
                .collection(COLLECTION)
                .add(dataForCurrentUser);

            await _firebaseFirestore
                .collection(COLLECTION)
                .where("id", isEqualTo: currentUser.id)
                .get()
                .then((snapshot) async {

                });
        

          } else {
            // if have any object contains id = currentUser.id
            // it will update field matchWith to collection

            QuerySnapshot snap = 
            await _firebaseFirestore
                .collection(COLLECTION)
                .where("id",isEqualTo: currentUserID).get();
            String currentDocID = snap.docs[0].id;

            _firebaseFirestore
                .collection(COLLECTION)
                .doc(currentDocID)
                .update({
              "matchWith": FieldValue.arrayUnion([userID])
            });
          }
    });
  }
}