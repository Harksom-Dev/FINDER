import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class UnmatchProvider{
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = "tempusers";

  //TODO unmath in matched db , delete like on the unmath user , delete chatroom

  //unmath in matching DB

  //delete like on both user
  removeLike(String gotUnmathUserEmail) async{
    User? gotUnmathUser = await _databaseRepository.getUserByEmail(gotUnmathUserEmail);

    User? unmatchUser = await _databaseRepository.getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email);    
    int? currentUserID = unmatchUser?.id;
    int? gettingUnmatchUserID = gotUnmathUser?.id;
    //need to change id to uid in the future
    QuerySnapshot snap = 
          await _firebaseFirestore
              .collection(COLLECTION)
              .where("id",isEqualTo: currentUserID).get();

    String currentDocID = snap.docs[0].id;
    await _firebaseFirestore.collection(COLLECTION)
      .doc(currentDocID)
      .update({
        "like": FieldValue.arrayRemove([gettingUnmatchUserID])
      });

    QuerySnapshot snap2 = 
          await _firebaseFirestore
              .collection(COLLECTION)
              .where("id",isEqualTo: gettingUnmatchUserID).get();

    String gotunmatchDocID = snap2.docs[0].id;
    await _firebaseFirestore.collection(COLLECTION)
      .doc(gotunmatchDocID)
      .update({
        "like": FieldValue.arrayRemove([currentUserID])
      });

      removeMatchingDB(currentUserID,gettingUnmatchUserID);
  }

  //delete matching db in firebase
  removeMatchingDB(var currentUserID,var gettingUnmatchUserID) async{
    QuerySnapshot snap = 
          await _firebaseFirestore
              .collection('MatchedData')
              .where("id",isEqualTo: currentUserID).get();

    String currentDocID = snap.docs[0].id;

    QuerySnapshot snap2 = 
          await _firebaseFirestore
              .collection('MatchedData')
              .where("id",isEqualTo: gettingUnmatchUserID).get();

    String gotunmatchDocID = snap2.docs[0].id;
    print(gettingUnmatchUserID);
    print(currentUserID);
    await _firebaseFirestore.collection('MatchedData')
      .doc(currentDocID)
      .update({
        "matchWith": FieldValue.arrayRemove([gettingUnmatchUserID])
      });

    await _firebaseFirestore.collection('MatchedData')
      .doc(gotunmatchDocID)
      .update({
        "matchWith": FieldValue.arrayRemove([currentUserID])
      });

  }

  removeChatroom(String? userEmail1,String userEmail2) async{
    String chatrommid = getChatRoomId(userEmail1!, userEmail2);
    print(chatrommid);
    
    QuerySnapshot snap = 
          await _firebaseFirestore
              .collection('ChatRoom')
              .where("chatroomid",isEqualTo: chatrommid).get();

    if(snap.docs.isEmpty){
      chatrommid = getChatRoomId(userEmail2, userEmail1);

      snap = 
          await _firebaseFirestore
              .collection('ChatRoom')
              .where("chatroomid",isEqualTo: chatrommid).get();
    }

    
    String currentDocID = snap.docs[0].id;

    //navigate through chats collection and delete every chat message
    await _firebaseFirestore
            .collection('ChatRoom')
            .doc(currentDocID).collection('chats')
            .get().then((snap){
              for(DocumentSnapshot ds in snap.docs){
                ds.reference.delete();
              }
            });
    //delete a field in ChatRoom doc
    await _firebaseFirestore
            .collection('ChatRoom')
            .doc(currentDocID)
            .delete();
  }

  getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
  }
}