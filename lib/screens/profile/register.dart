import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/profile.dart';
import 'package:date_field/date_field.dart';

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

  Profile profile = Profile(name: '', email: '', password: '', dob: '');

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your the password.'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 characters.'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'Passwords must have at least one special character')
  ]);
  String password = '';
  final DateTime now = DateTime.now();

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
                                  // * Name form
                                  Text("Name: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText: "Please enter your name."),
                                    onSaved: (String? value) {
                                      profile.name = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // * Email form
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
                                  // * Date form
                                  Text("Date of Birth: ",
                                      style: TextStyle(fontSize: 15)),
                                  DateTimeFormField(
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      // border: OutlineInputBorder(),
                                      // suffixIcon: Icon(Icons.event_note),
                                      // labelText: 'Only date',
                                    ),
                                    mode: DateTimeFieldPickerMode.date,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // initialDate: new DateTime.now(),
                                    firstDate: new DateTime(1922),
                                    lastDate: new DateTime(2023),
                                    validator: (e) {
                                      if (profile.dob == null ||
                                          e != profile.dob) {
                                        return "Please enter date";
                                      } else
                                        return null;
                                    },
                                    // validator: (e) => (e?.year ?? 0) >= 2004
                                    //     ? 'Your must be more than 18 year old to signup'
                                    //     : null,
                                    onDateSelected: (DateTime? value) {
                                      profile.dob = value;
                                      print(value.toString());
                                    },
                                    onSaved: (DateTime? value) {
                                      profile.dob = value;
                                      print("dob saved!");
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // * Password form
                                  Text("Password",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    obscureText: true,
                                    onChanged: (val) => password = val,
                                    onSaved: (String? value) {
                                      profile.password = value!;
                                    },
                                    validator: passwordValidator,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // * Confirm Password form
                                  Text("Confirm Password",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    validator: (val) => MatchValidator(
                                            errorText:
                                                'Passwords do not match.')
                                        .validateMatch(val!, password),
                                    obscureText: true,
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
                                              //try to get email and passfrom profie() and store to map
                                              Map<String, dynamic> userInfoMap =
                                                  {
                                                "uid": FirebaseAuth
                                                    .instance.currentUser?.uid,
                                                "name": profile.name,
                                                "email": profile.email,
                                                "dob": profile.dob,
                                                //can add more attribute for further update
                                              };
                                              //call uploaduserinfo from database.dart to update user to firestore
                                              DatabaseMethods()
                                                  .uploadUserInfo(userInfoMap);
                                            } on FirebaseAuthException catch (e) {
                                              print(e.code);
                                              String message;
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                message =
                                                    "This email is already taken";
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
