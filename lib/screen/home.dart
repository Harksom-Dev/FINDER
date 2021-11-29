import 'package:flutter/material.dart';
import 'package:loginsystem/screen/login.dart';
import 'package:loginsystem/screen/register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("FINDER", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label:
                      Text("Sign Up", style: TextStyle(fontSize: 20)),
                      onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context){
                          return RegisterScreen();
                      })
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  label: Text("Sign In", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context){
                          return LoginScreen();
                      })
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
