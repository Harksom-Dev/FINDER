import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/models/message_model.dart';

class DatabaseMethods {
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

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId,int messageNum) async {
    return  FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .limitToLast(messageNum)
        .snapshots();
  }

  allMessageSize(String chatRoomId) async {

    await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .get().then((snap) {
          // snap.docs.toList();
          Message.setSize(snap.docs.length);
        });

  }


  
  getChatRoom(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userEmail)
        .snapshots();
  }


  testdb() async{
    return await FirebaseFirestore.instance.collection("users")
      .doc('user1')
      .snapshots();
  }
}
