// ignore_for_file: camel_case_types, use_function_type_syntax_for_parameters

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/models/UpdateUser.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/screens/edit_profile/editprofile_interest.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class EditProfileScreen extends StatefulWidget {
  @override
  static const String routeName = '/editprofile';
  static User? userFromDB;

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => EditProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = true;
  //final User user = User.users[0];
  final formKey = GlobalKey<FormState>();
  final editnamecontroller = TextEditingController();
  final editbiocontroller = TextEditingController();
  UpdateUser updateprofile = UpdateUser(
    
    name: '',
    age: 0,
    bio: '',
    imageUrls: [],
    interested: [],
  );
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your the name.'),
    PatternValidator(r'^([A-z\\.-ᶜ]*(\s))*[A-z\\.-ᶜ]*\D$',
        errorText: "Name is invalid."),
  ]);
  final bioValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your the name.'),
    PatternValidator(r'^([A-z\\.-ᶜ]*(\s))*[A-z\\.-ᶜ]*\D$',
        errorText: "Bio is invalid."),
  ]);
  User? userFromDB = User.dummyUser;

  @override
  void initState() {
    getData();
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {});
  }

  @override
  Widget build(BuildContext context) {
    print("after set userFromDB = $userFromDB");
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userFromDB!.imageUrls[0],
            onClicked: () async {
              Navigator.pushNamed(context, "/uploadPicture");
            },
          ),
          const SizedBox(height: 30),
          Row(
                  children: [
                    CustomImageContainer(),
                    CustomImageContainer(),
                    CustomImageContainer(),
                    
                    SizedBox(width: 15),]),
          Text(
            "Name  ",
            style: TextStyle(fontSize: 15),
          ),
          TextFormField(
            controller: editnamecontroller,
            decoration: const InputDecoration(
              hintText: 'userFromDB!.name',
            ),
            onSaved: (String? valueF) {
              updateprofile.name = valueF!;
              debugPrint('valueF in test is  $valueF');
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: editbiocontroller,
            decoration: const InputDecoration(
              hintText: 'userFromDB!.name',
            ),
            onSaved: (String? valueF) {
              updateprofile.name = valueF!;
              debugPrint('valueF in test is  $valueF');
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                  child: RaisedButton(
                onPressed: () async {
                  print(editnamecontroller.text);
                  print(editbiocontroller.text);
                  //await Future.delayed(const Duration(seconds: 2));
                  //await Navigator.pushNamed(context, "/editprofile_interest");
                  {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Editprofile_interest(
                          editnamecontroller.text,
                          editbiocontroller.text,
                          updateprofile.interested,
                          userFromDB!.email,
                          updateprofile.imageUrls[0],
                          //ถ้าส่ง email ผ่านตรงนี้ได้
                        ),
                      ),
                    );
                  }
                },
                child: Text('Next'),
              ))
            ],
          )
        ],
      ),
    );
  }

  Future getData() async {
    print("perfrom getdata");
    await DatabaseRepository()
        .getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email)
        .then((userData) {
      print("before set userFromDB = $userData");
      userFromDB = userData;
      print("userFromDB = $userFromDB");
    });
  }
}
