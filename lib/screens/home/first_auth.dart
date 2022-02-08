// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:loginsystem/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class FirstAuth extends StatelessWidget {
  static const String routeName = '/first';

  const FirstAuth({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => FirstAuth(),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: InkWell(
                      onTap: () {
                        //todo: implement google login here!
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        Navigator.pushNamed(context, "/google login");
                        print("google auth !");
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
                              "Sign in with Google",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
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
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
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
                          children: const [
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
                        Text(
                          "Sign up with Email",
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
        ),
      );
}
