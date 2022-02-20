import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/models/UpdateUser.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/database_editprofile.dart';
import 'package:loginsystem/widgets/appbar_editprofile.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:loginsystem/screens/edit_profile/editprofile_screen.dart';

class Editprofile_interest extends StatefulWidget {
  static const String routeName = '/editprofile_interest';

  static Route route({
    required String UpdateName,
    required String UpdateBio,
    required List<String> UpdateInterest,
    required String updateEmail,
    required String updateimageURL,
  }) {
    return MaterialPageRoute(
      builder: (_) => Editprofile_interest(
          UpdateName, UpdateBio, UpdateInterest, updateEmail,updateimageURL),
      settings: RouteSettings(name: routeName),
    );
  }

  final String UpdateName;
  final String UpdateBio;
  List<String> UpdateInterest = [];
  final String updateEmail;
  final String updateimageURL;

  Editprofile_interest(
      this.UpdateName, this.UpdateBio, this.UpdateInterest, this.updateEmail,this.updateimageURL);
  Editprofile_interest_State createState() => Editprofile_interest_State();
}

class Editprofile_interest_State extends State<Editprofile_interest> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final List<String> _progLang = [
      "Python",
      "Java",
      "JavaScript",
      "Kotlin",
      "R",
      "PHP",
      "GO",
      "C",
      "Swift",
      "C#",
      "C++",
    ];
    final List<String> _sports = [
      "Soccer",
      "Basketball",
      "Tennis",
      "Baseball",
      "Running",
      "Volleyball",
      "Badminton",
      "Swimming",
      "Boxing",
      "Table tenis",
    ];
    final List<String> _musics = [
      "Pop",
      "Hiphop",
      "Jazz",
      "Blue",
      "Punk",
      "Indie Rock",
      "K-Pop",
      "T-Pop",
      "R&B",
      "Alternative",
    ];

    final _itemsPL = _progLang.map((e) => MultiSelectItem(e, e)).toList();
    final _itemsSP = _sports.map((e) => MultiSelectItem(e, e)).toList();
    final _itemsMS = _musics.map((e) => MultiSelectItem(e, e)).toList();

    /// DATA
    List<Object?> _SelectedProLang = [];
    List<Object?> _SelectedMusics = [];
    List<Object?> _SelectedSports = [];
    List<Object?> _Selected = [];
    final _multiSelectKey = GlobalKey<FormFieldState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
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
                  SizedBox(height: 15),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black45),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  //################################################################################################
                  SizedBox(height: 15),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black45),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  //################################################################################################
                  SizedBox(height: 15),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black45),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                          child: RaisedButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, "/profile");
                          _Selected.addAll(_SelectedProLang);
                          _Selected.addAll(_SelectedMusics);
                          _Selected.addAll(_SelectedSports);
                          int n = _Selected.length;
                          for (int i = 0; i < n; i++) {
                            String current = _Selected.elementAt(i).toString();
                            widget.UpdateInterest.add(current);
                          }
                          Map<String, dynamic> userInfoMap = {
                            "uid": FirebaseAuth.instance.currentUser?.uid,
                            "name": widget.UpdateName,
                            "bio": widget.UpdateBio,
                            "interested": widget.UpdateInterest,

                            //can add more attribute for further update
                          };
                          DatabaseUpdateMethods()
                              .updateUserInfo(userInfoMap, widget.updateEmail);
                        },
                        child: Text('finish'),
                      ))
                    ],
                  )
                ],
              ),
            )));
  }
}
