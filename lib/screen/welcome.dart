import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/temp';
  final auth = FirebaseAuth.instance;

 static Route route() {
    return MaterialPageRoute(
      builder: (_) => WelcomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = auth.currentUser!.email;
    return Scaffold(
      appBar:AppBar(title: Text(user!,style: TextStyle(fontSize: 25)),
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