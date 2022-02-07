import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/profile.dart';
import 'package:loginsystem/screens/messagebox/chatroom_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(name: '', email: '', password: '', dob: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFF594B7),
                        Color(0xFFBD84EC),
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Image.asset("assets/icon/finder_logo.png"),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text("Email address: ",
                                  style: TextStyle(fontSize: 15)),
                              TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                          "Please enter your email address."),
                                  EmailValidator(errorText: "Email is invalid")
                                ]),
                                // decoration: InputDecoration(
                                //   border: OutlineInputBorder(),
                                // ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String? email) {
                                  profile.email = email!;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Password: ",
                                  style: TextStyle(fontSize: 15)),
                              TextFormField(
                                validator: RequiredValidator(
                                    errorText:
                                        "The password should not be empty"),
                                obscureText: true,
                                onSaved: (String? password) {
                                  profile.password = password!;
                                },
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        try {
                                          //add login to pref
                                          HelperFunction
                                              .saveUserEmailSharedPreference(
                                                  profile.email);
                                          HelperFunction
                                              .saveUserLoggedInSharedPreference(
                                                  true);
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: profile.email,
                                                  password: profile.password)
                                              .then((value) {
                                            formKey.currentState!.reset();
                                            // Navigator.pushReplacement(context,
                                            // MaterialPageRoute(builder: (context){
                                            //     return ChatRoom();
                                            // }));
                                            Navigator.pushNamed(context, "/");
                                            print("swipe screen is home!");
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.message!,
                                              gravity: ToastGravity.CENTER);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
