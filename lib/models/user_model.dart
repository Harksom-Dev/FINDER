import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:loginsystem/helper/constants.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final String bio;
  final List<dynamic> interested;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.interested,
    required this.email
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
        bio: snap['bio'],
        email:snap['email']);
        

    return user;
  }
  static set(List<User> user,userEmail){
    users.clear();
    for(int i = 0; i < user.length;i++){    //now this work but need to tweak to real use
      if(userEmail != user[i].email){
        users.add(user[i]);
      }
      
    }
  }


  static setInterested(List<dynamic> interested){
    userInterested.clear();
    for(int i = 0; i < interested.length;i++){    //now this work but need to tweak to real use
        userInterested.add(interested[i]);
      
    }
    print(userInterested);

  }
// static List<User> users = [];
  static List<User> userfromSnapshot(QuerySnapshot snap) {
    //this func need to get snap from firebase lib and turn in to list<User>

    return snap.docs
        .map((doc) => User(
            id: doc['id'],
            name: doc['name'],
            age: doc['age'],
            imageUrls: doc['imageUrls'],
            bio: doc['bio'],
            interested: doc['interested'],
            email: doc['emial']))
        .toList();
  } 
  
  
  //dummy data to prevent error at first when buiding an app
  static List<User> users = [
    const User(
        id: 1,
        name: 'Pack',
        email: 'pack@g.coom',
        age: 21,
        imageUrls: [
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
          'https://firebasestorage.googleapis.com/v0/b/finder-login-application.appspot.com/o/image%2F1.jpg?alt=media&token=8235eca6-7195-4a16-bf9c-a95282e2a727',
        ],
        bio: 'i love coding',
        interested: ['C++', 'python']),
    const User(
        id: 2,
        name: 'Yoyo',
        email: 'y@g.coom',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
        ],
        bio: 'i love coding',
        interested: ['C++', 'python']),
    const User(
        id: 3,
        name: 'Phird',
        email: 'p@g.coom',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80',
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80',
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'
        ],
        bio: 'i love coding mak mak',
        interested: ['C++', 'python']),
    const User(
        id: 4,
        name: 'Phirachat',
        email: 'p@g.coom',
        age: 21,
        imageUrls: [
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
        ],
        bio: 'i love coding mak mak',
        interested: ['C++', 'python']),
  ];

  //another dummy data
  static List<String> userInterested = [
    'c++',
    'dart'
  ];
}
