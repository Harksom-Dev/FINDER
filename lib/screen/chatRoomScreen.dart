import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/screen/search.dart';

import 'home.dart';

class ChatRoom extends StatefulWidget {

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final auth = FirebaseAuth.instance;
  
  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myEmail = await HelperFunction.getUserEmailSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(auth.currentUser.email,style: TextStyle(fontSize: 25)),
      actions: [
          ElevatedButton(
                  child: Text("Sign Out"),
                  onPressed: (){
                      auth.signOut().then((value){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                            return HomeScreen();
                        }));
                      });
                  }, 
                )
        ],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchScreen()
            ));
        },
        ),
    );
  }
}