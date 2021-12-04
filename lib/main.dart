import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/screen/chatRoomScreen.dart';
import 'package:loginsystem/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    Firebase.initializeApp();
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunction.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn ? ChatRoom() : HomeScreen()
    );
  }
}

