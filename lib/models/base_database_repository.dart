import 'package:loginsystem/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Future<List<User>> getUser();

  Future<User?> getUserByEmail(String email);
  Future<void> updateUserPicture(
      String imageName); //this maybe not use in this branch
  Future<void> getAllDataFromCollection(String collectionName);
  Future<void> updateUserName(String FullName);
  Future<void> updateUserAbout(String About);

  Stream<List<User>> getAllUsers();
  testdb();
  Future<List<User>> usertoList();
  getLikedAndUnlikedListByID(int id);
  userInterested();
  userLikedAndDisliked();
  cleardislike();
}
