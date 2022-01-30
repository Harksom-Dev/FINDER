import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/profile.dart';

class RegisterScreen extends StatefulWidget {
  @override
  static const String routeName = '/register';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => RegisterScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  Profile profile = Profile(email: '', password: '');

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
                        Color(0xFF8FAEF8),
                        Color(0xFF4B5C83),
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Name: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter your Name."),
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email) {
                                      profile.email = email!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Email: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              "Please enter your email address."),
                                      EmailValidator(
                                          errorText: "Email is invalid")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email) {
                                      profile.email = email!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Date of Birth: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText:
                                            "Please enter your password."),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      profile.password = password!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Password",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText:
                                            "Please enter your password."),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      profile.password = password!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Confirm Password",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText:
                                            "Please enter your password."),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      profile.password = password!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 52,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                        child: Text("Next",
                                            style: TextStyle(fontSize: 15)),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            try {
                                              //try to get email and passfrom profie() and store to map
                                              Map<String, String> userInfoMap =
                                                  {
                                                "email": profile.email
                                                //can add more attribute for further update
                                              };
                                              //call uploaduserinfo from database.dart to update user to firestore
                                              DatabaseMethods()
                                                  .uploadUserInfo(userInfoMap);
                                              //save register user using helperfunction
                                              HelperFunction
                                                  .saveUserLoggedInSharedPreference(
                                                      true);
                                              HelperFunction
                                                  .saveUserEmailSharedPreference(
                                                      profile.email);

                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: profile.email,
                                                      password:
                                                          profile.password)
                                                  .then((value) {
                                                formKey.currentState!.reset();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Account has been created.",
                                                    gravity: ToastGravity.TOP);
                                                Navigator.pushNamed(
                                                    context, "/");
                                                print("swipescreen !");
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              print(e.code);
                                              String message;
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                message =
                                                    "This email is already taken";
                                              } else if (e.code ==
                                                  'weak-password') {
                                                message =
                                                    "Password must be at least 6 characters.";
                                              } else {
                                                message = e.message!;
                                              }
                                              Fluttertoast.showToast(
                                                  msg: message,
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
