import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/models/base_database_repository.dart';
import 'package:loginsystem/models/storage/storage_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class DatabaseRepository extends BaseDatabaseRepository{
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() { // get 1 user from firebase
    // TODO: implement getUser
    return _firebaseFirestore.collection('users')
            .doc('user1').snapshots().map((snap) => User.fromSnapshot(snap));
  }


  @override
  Future<void> updateUserPicture(String imageName) async {
    // TODO: implement updateUserPicture
    String downloadUrl = await StorageRepository().getDownloadURL(imageName);
    return _firebaseFirestore.collection('users').doc('user1').update({'imageUrls':FieldValue.arrayUnion([downloadUrl])});
  }

  @override
  Stream<List<User>> getAllUsers() {    //trting to get all of users data collectiong from firebase and pass it to userfromSnapshot in user_model
    return _firebaseFirestore.collection('users').snapshots().map((snap) => User.userfromSnapshot(snap));    //maybe use forloop for add a user in this snapshot
  }

  @override
  testdb() async {
    return await FirebaseFirestore.instance.collection("users")
      .snapshots();
  }
  
}