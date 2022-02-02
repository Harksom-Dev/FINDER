import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final String bio;
  final List<dynamic> interested;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.interested,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        bio,
        interested,
      ];
  static User fromSnapshot(DocumentSnapshot snap) {
    //this funct convert data from firebase to 1 of User
    User user = User(
        id: snap['id'],
        name: snap['name'],
        age: snap['age'],
        imageUrls: snap['imageUrls'],
        interested: snap['interested'],
        bio: snap['bio']);

    return user;
  }
  static set(List<User> user){
    print(user[0]);
    // users.clear();
    // users.addAll(users);
    print(user.length);
    print(users.length);
    users.clear();
    for(int i = 0; i < user.length;i++){    //now this work but need to tweak to real use
      // users[i] = user[i];
      users.add(user[i]);
    }
  }
// static List<User> users = [];
  static List<User> userfromSnapshot(QuerySnapshot snap) {
    //this func need to get snap from firebase lib and turn in to list<User>
    // users = 
    print("heloooooo");
    return snap.docs
        .map((doc) => User(
            id: doc['id'],
            name: doc['name'],
            age: doc['age'],
            imageUrls: doc['imageUrls'],
            bio: doc['bio'],
            interested: doc['interested']))
        .toList();
    // List<User> users =
  } 
  
  

  static List<User> users = [
    User(
        id: 1,
        name: 'Pack',
        age: 21,
        imageUrls: [
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
        ],
        bio: 'i love coding',
        interested: ['C++', 'python']),
    User(
        id: 2,
        name: 'Yoyo',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
        ],
        bio: 'i love coding',
        interested: ['C++', 'python']),
    User(
        id: 3,
        name: 'Phird',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80',
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80',
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'
        ],
        bio: 'i love coding mak mak',
        interested: ['C++', 'python']),
    User(
        id: 4,
        name: 'Phirachat',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
        ],
        bio: 'i love coding mak mak',
        interested: ['C++', 'python']),
  ];
}
