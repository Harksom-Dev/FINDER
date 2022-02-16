import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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
  static set(List<User> user){
    isdislikeclear = false;
    users.clear();
    // for(int i = 0;i<user.length;i++){
    //   print(user[i].name);
    // }
    // print(user);
    //random index in user that we get
    Random rnd;
    rnd = Random();
    List<User> unrank = [];
    List<int> rand = [];
    //get a like and dislike list
    //get random list in maximum 10 user
    //first check if the number of user we get is morethan our quota or not 
    if(user.length >= 15){      
      //in this case random number in our of user length 10 time and add to users list
      //first we need to random 10 number and check not to duplicate that number
        int likeanddislike = userLiked.length + userdisliked.length; 
        print('likeanddis is  $likeanddislike');
        print(user.length-1);
        if(likeanddislike == user.length){
          print('clear');
          userdisliked.clear();
          isdislikeclear = true;
        }
      for(int i = 0;i<15;i++){
        int r = 0 + rnd.nextInt(user.length);
        int targetuser = user[r].id;  //in the future we gonna change to String and become uid
        if(!rand.contains(r) && !userLiked.contains(targetuser) && !userdisliked.contains(targetuser)){
          // print(targetuser);
          unrank.add(user[r]);
          rand.add(r);
        }else{
          i--;
        }
        

      }
    }else{
        int size = user.length-userLiked.length;
        int likeanddislike = userLiked.length + userdisliked.length; 
        print('likeanddis is  $likeanddislike');
        print(user.length-1);
        if(likeanddislike == user.length){
          print('clear');
          userdisliked.clear();
          isdislikeclear = true;
        }else{
          size = user.length - userdisliked.length - userLiked.length;
        }
      for(int i = 0;i<size;i++){
        int r = 0 + rnd.nextInt(user.length);
        int targetuser = user[r].id;  //in the future we gonna change to String and become uid
        if(!rand.contains(r) && !userLiked.contains(targetuser) && !userdisliked.contains(targetuser)){
          // print(targetuser);
          unrank.add(user[r]);
          rand.add(r);
        }else{
          i--;
        }
        

      }
    }

    //now that we get 15 list next is divide in 3 catagory
    List<User> bestlist = [];
    List<User> oklist = [];
    List<User> nolist = [];

    //loop through unrank list
    for(int i = 0;i < unrank.length;i++){
      int similarCount = 0;
      for(int j = 0;j < unrank[i].interested.length;j++){
        if(userInterested.contains(unrank[i].interested[j])){
          similarCount++;
        }
      }
      if(similarCount >= 3){
        bestlist.add(unrank[i]);
      }else if (similarCount >= 1){
        oklist.add(unrank[i]);
      }else{
        nolist.add(unrank[i]);
      }
    }

    //now we devide 3 list 
    //next is random with ratio to add to User list
    //the ratio is 1-100 0-20 is nolist 21-50 is oklist 50-100 is best list
    for(int i = 0; i < unrank.length;i++){
      var r = 0 + rnd.nextInt(100);
      if(r >= 50){
        if(bestlist.isNotEmpty){
          users.add(bestlist[0]);
          bestlist.removeAt(0);
          // print('best add');
        }else{
          i--;
        }
      }else if(r > 20){
        if(oklist.isNotEmpty){
          users.add(oklist[0]);
          oklist.removeAt(0);
          // print('ok add');
        }else{
          i--;
        }
      }else{
        if(nolist.isNotEmpty){
          users.add(nolist[0]);
          nolist.removeAt(0);
          // print('no add');
        }else{
          i--;
        }
      }
    }
    
    for(int i = 0;i<users.length;i++){
      print(users[i].name);
    }
    
  }


  static setInterested(List<dynamic> interested){
    userInterested.clear();
    for(int i = 0; i < interested.length;i++){    //now this work but need to tweak to real use
        userInterested.add(interested[i]);
    }
    // print(userInterested);

  }
  static setLiked(List<dynamic> likes){
    
      userLiked.clear();
      for(int i = 0; i < likes.length;i++){    //now this work but need to tweak to real use
        userLiked.add(likes[i]);
    }
    
    
    // print(userLiked);

  }
  static setDisliked(List<dynamic> unlike){
    
      userdisliked.clear();
      for(int i = 0; i < unlike.length;i++){    //now this work but need to tweak to real use
      userdisliked.add(unlike[i]);
    }
    
    
    // print(userdisliked);

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
            email: doc['email']))
        .toList();
  } 
  
  
  //dummy data to prevent error at first when buiding an app
  static List<User> users = [
    const User(
        id: 1,
        name: 'dummyPack',
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
    
  ];

  //another dummy data
  static List<String> userInterested = [
    'c++',
    'dart'
  ];

  static List<int> userLiked = [1];

  static List<int> userdisliked = [1];
  static bool isdislikeclear = false;
}
