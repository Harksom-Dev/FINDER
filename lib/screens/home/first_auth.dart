import 'package:flutter/material.dart';
import 'package:loginsystem/screens/profile/login.dart';
import 'package:loginsystem/screens/profile/register.dart';
import 'package:loginsystem/widgets/Menu_button.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF594B7),
                Color(0xFFBD84EC),
                Color(0xFF906CCC),
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Column(
            children: [
              Image.asset("assets/finderlogo.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Connect with other people",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                    print("sign up !");
                  },
                  child: Container(
                    width: 335,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFFF95B5B),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/googleiconwhite.png",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign up with Google",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                    print("sign In !");
                  },
                  child: Container(
                    width: 335,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_rounded),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Sign up with Email",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("already a Member ?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                  print("LogIn !");
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("Login",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
