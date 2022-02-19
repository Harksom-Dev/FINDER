

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/models/match_data_model.dart';
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
      await addMatchedUserToMatchedData(currentUser, userWhoGotLiked);
      await addMatchedUserToMatchedData(userWhoGotLiked, currentUser);
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
            Map<String, dynamic> mapForMatchWith = {"id": user.id,"name": user.name};
            Map<String, dynamic> dataForCurrentUser = {
              "email": currentUser.email,
              "name": currentUser.name,
              "id": currentUserID,
              "matchWith": [mapForMatchWith]
            };

            _firebaseFirestore
                .collection(COLLECTION)
                .add(dataForCurrentUser);
                

          } else {
            // if have any object contains id = currentUser.id
            // it will update field matchWith to collection
            Map<String, dynamic> mapForMatchWith = {"id": user.id,"name": user.name};
            QuerySnapshot snap = 
            await _firebaseFirestore
                .collection(COLLECTION)
                .where("id",isEqualTo: currentUserID).get();
            String currentDocID = snap.docs[0].id;

            _firebaseFirestore
                .collection(COLLECTION)
                .doc(currentDocID)
                .update({
              "matchWith": FieldValue.arrayUnion([mapForMatchWith])
            });
          }
    });
  }

  // Future<MatchData> getMatchedDataByUser(User user) async {
  //   QuerySnapshot qsnap = await _firebaseFirestore
  //       .collection(COLLECTION)
  //       .where("id", isEqualTo: user.id)
  //       .get();
  //   return  MatchData(
  //             id: qsnap.docs[0].get('id'),
  //             matchWith: qsnap.docs[0].get('matchWith'));
  // }

}