import 'package:loginsystem/models/user_model.dart';

abstract class BaseDatabaseRepository{
  Future<List<User>> getUser();
  Future<void> updateUserPicture(String imageName); //this maybe not use in this branch
  Stream<List<User>>getAllUsers();
  testdb();
  Future<List<User>> usertoList();
  userInterested();
  userLikedAndDisliked();
  cleardislike();
}