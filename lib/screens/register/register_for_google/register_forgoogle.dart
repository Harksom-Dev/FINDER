import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/models/profile.dart';
import 'package:date_field/date_field.dart';
import 'package:loginsystem/screens/register/register_2.dart';
import 'package:loginsystem/screens/register/register_for_google/register_2_forgoogle.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:loginsystem/screens/register/customvalidator.dart';

// ignore: must_be_immutable
class RegisterScreenForGoogle extends StatefulWidget {
  final String? profileName;
  final String? profileEmail;

  const RegisterScreenForGoogle(this.profileName, this.profileEmail, {Key? key})
      : super(key: key);

  
  @override
  _RegisterScreenForGoogleState createState() =>
      _RegisterScreenForGoogleState();
}

class _RegisterScreenForGoogleState extends State<RegisterScreenForGoogle> {
  bool isLoading = false;
  bool _isLoading = true;
  final formKey = GlobalKey<FormState>();

  Profile profile =
      Profile(name: '', email: '', password: '', dob: '', interest: []);

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  String password = '';
  final DateTime now = DateTime.now();
  //* Validator
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your the password.'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 characters.'),
  ]);
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your the name.'),
    PatternValidator(r'^([A-z\\.-ᶜ]*(\s))*[A-z\\.-ᶜ]*\D$',
        errorText: "Name is invalid."),
  ]);
  final mailValidator = MultiValidator([
    RequiredValidator(errorText: "Please enter your email address."),
    EmailValidator(errorText: "Email is invalid"),
    CustomValidator("Email is already in use"),
  ]);

  @override
  void initState() {
    super.initState();
    //Using Timer
    Timer(Duration(milliseconds: 900), () {
      setState(() {
        _isLoading = false;
      });
    });
    //Future.delayed
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        _isLoading = false;
      });
    });
    //setState is very important, otherwise the data will not be updated! ! !
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (!_isLoading) {
            if (snapshot.connectionState == ConnectionState.done) {
              String? userName = widget.profileName;
              String? userEmail = widget.profileEmail;
              print("name: $userName ${widget.profileName}");
              print("email: $userEmail ${widget.profileEmail}");
              return Scaffold(
                appBar: const RegisterAppbar(),
                body: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              padding:
                                  const EdgeInsets.fromLTRB(30, 30, 30, 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // * Name form
                                  const Text("Name: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    controller: TextEditingController()
                                      ..text = userName.toString(),
                                    validator: nameValidator,
                                    onSaved: (String? value) {
                                      value!;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // * Email form
                                  const Text("Email: ",
                                      style: TextStyle(fontSize: 15)),
                                  TextFormField(
                                    controller: TextEditingController()
                                      ..text = userEmail.toString(),
                                    // autovalidateMode:
                                    //     AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email) {
                                      profile.email = email!;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // * Date form
                                  const Text("Date of Birth: ",
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
                                    firstDate: DateTime(1922),
                                    lastDate: DateTime(2023),
                                    validator: (e) {
                                      if (profile.dob == null ||
                                          e != profile.dob) {
                                        return "Please enter date";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onDateSelected: (DateTime? value) {
                                      profile.dob = value;
                                      print(value.toString());
                                    },
                                    onSaved: (DateTime? value) {
                                      profile.dob = value;
                                      print("dob saved!");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 10, 50, 0),
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
                                        // child: Text("Next",
                                        //     style: TextStyle(fontSize: 15)),
                                        child: isLoading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text('Next'),
                                        onPressed: () async {
                                          if (isLoading) return;
                                          setState(() => isLoading = true);
                                          formKey.currentState!.validate();
                                          await Future.delayed(
                                              const Duration(seconds: 2));
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              formKey.currentState!.save();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterInterestScreenForGoogle(
                                                    profile.name,
                                                    profile.email,
                                                    profile.dob,
                                                    profile.interest,
                                                  ),
                                                ),
                                              );
                                              setState(() => isLoading = false);
                                              formKey.currentState!.reset();
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
                                          } else {
                                            setState(() => isLoading = false);
                                            return;
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
                ),
              );
            }
          } else {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: const CircularProgressIndicator(
                  color: Colors.pink,
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
