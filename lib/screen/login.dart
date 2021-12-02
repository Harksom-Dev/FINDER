import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/model/profile.dart';
import 'package:loginsystem/screen/chatRoomScreen.dart';
import 'package:loginsystem/screen/welcome.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                  ),
                body: Center(child: Text("${snapshot.error}"),
                ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Sign In"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("email address", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Please enter your email address."),
                              EmailValidator(errorText: "Email is invalid")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String email) {
                              profile.email = email;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Password", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(errorText: "The password should not be empty"),
                              obscureText: true,
                              onSaved: (String password) {
                              profile.password = password;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Sign In",style: TextStyle(fontSize: 20)),
                              onPressed: () async{
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  try{

                                    //add login to pref
                                    HelperFunction.saveUserEmailSharedPreference(profile.email);
                                    HelperFunction.saveUserLoggedInSharedPreference(true);
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: profile.email, 
                                      password: profile.password)
                                      .then((value){
                                          formKey.currentState.reset();
                                          Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context){
                                              return ChatRoom();
                                          }));
                                      });
                                  }on FirebaseAuthException catch(e){
                                      Fluttertoast.showToast(
                                        msg: e.message,
                                        gravity: ToastGravity.CENTER
                                      );
                                  }
                                }
                              },
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