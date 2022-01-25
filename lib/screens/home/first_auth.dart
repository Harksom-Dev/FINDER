import 'package:flutter/material.dart';
import 'package:loginsystem/screens/profile/login.dart';
import 'package:loginsystem/screens/profile/register.dart';

class first_auth extends StatelessWidget {
  @override

  static const String routeName = '/first';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => first_auth(),
      settings: RouteSettings(name: routeName),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temporary firstpage"),
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
                    //   Navigator.pushReplacement(context, MaterialPageRoute(
                    //     builder: (context){
                    //       return RegisterScreen();
                    //   })
                    // );
                      Navigator.pushNamed(context, "/register");
                              print("sign up !");
                    
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  label: Text("Sign In", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute(
                    //     builder: (context){
                    //       return LoginScreen();
                    //   })
                    // );

                    Navigator.pushNamed(context, "/login");
                              print("sign In !");
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