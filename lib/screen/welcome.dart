import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {

  final auth = FirebaseAuth.instance;

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
        ],
        ),
     
    );
  }
}