import 'package:loginsystem/models/user_model.dart';

abstract class BaseDatabaseRepository{
  Stream<User> getUser();
  Future<void> updateUserPicture(String imageName); //this maybe not use in this branch
  Stream<List<User>>getAllUsers();
  testdb();
  Future<List<User>> usertoList();
  Future<List<String>> userInterested();
}