import 'dart:math';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/models/profile.dart';
import 'package:date_field/date_field.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:loginsystem/widgets/appBar_userreview.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterInterestScreen extends StatefulWidget {
  static const String routeName = '/resigterInterest';

  static Route route({
    required String profileName,
    required String profileEmail,
    required dob,
    required String profilePassword,
  }) {
    return MaterialPageRoute(
      builder: (_) => RegisterInterestScreen(
          profileName, profileEmail, dob, profilePassword),
      settings: RouteSettings(name: routeName),
    );
  }

  final String profileName;
  final String profileEmail;
  final dob;
  final String profilePassword;
  RegisterInterestScreen(
      this.profileName, this.profileEmail, this.dob, this.profilePassword);

  _RegisterInterestScreenState createState() => _RegisterInterestScreenState();
}

class _RegisterInterestScreenState extends State<RegisterInterestScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    //final String name = "Interest";
    //final _items1 = _proLang.map((Interest) => MultiSelectItem(value, label));
    final List<Interest> _progLang = [
      Interest(cat: 1, id: 1, name: "Python"),
      Interest(cat: 1, id: 2, name: "Java"),
      Interest(cat: 1, id: 3, name: "JavaScript"),
      Interest(cat: 1, id: 4, name: "Kotlin"),
      Interest(cat: 1, id: 5, name: "R"),
      Interest(cat: 1, id: 6, name: "PHP"),
      Interest(cat: 1, id: 7, name: "GO"),
      Interest(cat: 1, id: 8, name: "C"),
      Interest(cat: 1, id: 9, name: "Swift"),
      Interest(cat: 1, id: 10, name: "C#"),
      Interest(cat: 1, id: 11, name: "C++"),
    ];
    final List<Interest> _sports = [
      Interest(cat: 3, id: 1, name: "Soccer"),
      Interest(cat: 3, id: 2, name: "Basketball"),
      Interest(cat: 3, id: 3, name: "Tennis"),
      Interest(cat: 3, id: 4, name: "Baseball"),
      Interest(cat: 3, id: 5, name: "Running"),
      Interest(cat: 3, id: 6, name: "Volleyball"),
      Interest(cat: 3, id: 7, name: "Badminton"),
      Interest(cat: 3, id: 8, name: "Swimming"),
      Interest(cat: 3, id: 9, name: "Boxing"),
      Interest(cat: 3, id: 10, name: "Table tenis"),
    ];
    final List<Interest> _musics = [
      Interest(cat: 2, id: 1, name: "Pop"),
      Interest(cat: 2, id: 2, name: "Hiphop"),
      Interest(cat: 2, id: 3, name: "Jazz"),
      Interest(cat: 2, id: 4, name: "Blue"),
      Interest(cat: 2, id: 5, name: "Punk"),
      Interest(cat: 2, id: 6, name: "Indie Rock"),
      Interest(cat: 2, id: 7, name: "K-Pop"),
      Interest(cat: 2, id: 8, name: "T-Pop"),
      Interest(cat: 2, id: 9, name: "R&B"),
      Interest(cat: 2, id: 10, name: "Alternative"),
    ];

    final _itemsPL = _progLang.map((e) => MultiSelectItem(e, e.name)).toList();
    final _itemsSP = _sports.map((e) => MultiSelectItem(e, e.name)).toList();
    final _itemsMS = _musics.map((e) => MultiSelectItem(e, e.name)).toList();

    /// DATA ///////////////////////////////////////////////////////
    List<Object?> _SelectedProLang = [];
    List<Object?> _SelectedMusics = [];
    List<Object?> _SelectedSports = [];
    List<Object?> _Selected = [];
    final _multiSelectKey = GlobalKey<FormFieldState>();

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: RegisterAppbar(),
      body: Container(
        //alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8FAEF8),
                Color(0xFF4B5C83),
              ]),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              //################################################################################################
              // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
              // decoration applied. This allows the ChipDisplay to render inside the same Container.
              //################################################################################################
              Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: Text(
                      "Favorite Programing Languages",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text("Programing Languages",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    buttonIcon: Icon(
                      Icons.code_sharp,
                      color: Colors.white,
                    ),
                    items: _itemsPL,
                    selectedColor: Colors.pink.withAlpha(20),
                    unselectedColor: Colors.white,
                    onConfirm: (values) {
                      _SelectedProLang = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _SelectedProLang.remove(value);
                        });
                      },
                    ),
                  ),
                  _SelectedProLang == null && _SelectedProLang.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "None Selected",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          ),
                        )
                      : Container(),
                ],
              ),
              //################################################################################################
              SizedBox(height: 40),
              //########### SPORT ######################################################################
              Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: Text(
                      "Favorite Sports",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text("Sports",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )),
                    buttonIcon: Icon(
                      Icons.sports_soccer_sharp,
                      color: Colors.white,
                    ),
                    items: _itemsSP,
                    selectedColor: Colors.pink.withAlpha(20),
                    unselectedColor: Colors.white,
                    onConfirm: (values) {
                      _SelectedSports = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _SelectedSports.remove(value);
                        });
                      },
                    ),
                  ),
                  _SelectedSports == null && _SelectedSports.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "None Selected",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          ),
                        )
                      : Container(),
                ],
              ),
              //################################################################################################
              SizedBox(height: 40),
              //##############  MUSICs   ################################################################
              Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: Text(
                      "Favorite Genre of Music",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text("Musics",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )),
                    buttonIcon: Icon(
                      Icons.music_note_rounded,
                      color: Colors.white,
                    ),
                    items: _itemsMS,
                    selectedColor: Colors.pink.withAlpha(20),
                    unselectedColor: Colors.white,
                    onConfirm: (values) {
                      _SelectedMusics = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _SelectedMusics.remove(value);
                        });
                      },
                    ),
                  ),
                  _SelectedMusics == null && _SelectedMusics.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "None Selected",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black45),
                          ),
                        )
                      : Container(),
                ],
              ),
              //################################################################################################
              SizedBox(height: 40),

              SizedBox(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.done_all_rounded),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Next",
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
            ],
          ),
        ),
      ),
    );
  }
}
