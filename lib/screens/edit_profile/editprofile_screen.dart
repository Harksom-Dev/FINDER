// ignore_for_file: camel_case_types, use_function_type_syntax_for_parameters

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/widgets/widget.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/editprofile';

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
  final User user = User.users[0];
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _displayNameValid = true;
  bool _bioValid = true;
  bool isLoading = false;

  DatabaseRepository _databaseRepository = DatabaseRepository();
   @override
  void initState() {
    super.initState();
    displayNameController.text = user.name;
    bioController.text = user.bio;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imageUrls[0],
            onClicked: () async {
              Navigator.pushNamed(context, "/uploadPicture");
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: user.name,
            onChanged: (name) {
              print("Text $name");
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.bio,
            maxLines: 3,
            onChanged: (about) {
              print('name ');
            },
          ),Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: displayNameController,
              decoration: InputDecoration(hintText: "Update Display Name ",
              errorText: _displayNameValid ? null : "Display Name too short"),
            )
          ],)
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                  child: RaisedButton(
                onPressed: () => {},
                child: Text('Save'),
              ))
            ],
          )
        ],
      ),
    );
  }
}


