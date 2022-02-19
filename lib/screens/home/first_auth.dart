// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/provider/google_sign_in.dart';
import 'package:loginsystem/screens/register/register_for_google/register_forgoogle.dart';
import 'package:provider/provider.dart';

class FirstAuth extends StatelessWidget {
  static const String routeName = '/first';

  final user = FirebaseAuth.instance.currentUser;

  FirstAuth({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => FirstAuth(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: Scaffold(
          /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          ),*/
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
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
                      onTap: () async {
                        //todo: implement google login here!
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        await provider.googleLogin();
                        QuerySnapshot snapshot = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('email',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.email)
                            .get();

                        if (snapshot.docs.isEmpty) {
                          if (FirebaseAuth.instance.currentUser != null) {
                            print(
                                "google auth ! Name: ${FirebaseAuth.instance.currentUser!.displayName}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreenForGoogle(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName,
                                    FirebaseAuth.instance.currentUser!.email,
                                  ),
                                ));
                          }
                        }
                        else {
                          Navigator.pushNamed(context, '/');
                        }
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
                      ),
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
        ),
      );
}
