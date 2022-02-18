import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterInterestScreen extends StatefulWidget {
  static const String routeName = '/resigterInterest';

  static Route route({
    required String profileName,
    required String profileEmail,
    required dob,
    required String profilePassword,
    required List<String> profileInterest,
  }) {
    return MaterialPageRoute(
      builder: (_) => RegisterInterestScreen(
          profileName, profileEmail, dob, profilePassword, profileInterest),
      settings: RouteSettings(name: routeName),
    );
  }

  final String profileName;
  final String profileEmail;
  final dob;
  final String profilePassword;
  List<String> profileInterest = [];

  RegisterInterestScreen(this.profileName, this.profileEmail, this.dob,
      this.profilePassword, this.profileInterest);

  _RegisterInterestScreenState createState() => _RegisterInterestScreenState();
}

class _RegisterInterestScreenState extends State<RegisterInterestScreen> {
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
                Color(0xFF654B92),
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
                  onTap: () async {
                    _Selected.addAll(_SelectedProLang);
                    _Selected.addAll(_SelectedMusics);
                    _Selected.addAll(_SelectedSports);
                    // print("After merge list $_Selected");
                    // print(widget.profileName);
                    // print(widget.profileEmail);
                    // print(widget.profilePassword);
                    // print(widget.dob);

                    int n = _Selected.length;

                    for (int i = 0; i < n; i++) {
                      String current = _Selected.elementAt(i).toString();
                      widget.profileInterest.add(current);
                    }

                    HelperFunction.saveUserLoggedInSharedPreference(true);
                    HelperFunction.saveUserEmailSharedPreference(
                        widget.profileEmail);

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: widget.profileEmail,
                            password: widget.profilePassword)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Account has been created.",
                          gravity: ToastGravity.TOP);
                      Navigator.pushNamed(context, "/");
                      print("swipescreen !");
                    });
                    //try to get email and passfrom profie() and store to map
                    Map<String, dynamic> userInfoMap = {
                      "uid": FirebaseAuth.instance.currentUser?.uid,
                      "name": widget.profileName,
                      "email": widget.profileEmail,
                      "dob": widget.dob,
                      "interested": widget.profileInterest,
                      "imgUrl": [],
                      "like": [],
                      "dislike": [],
                      //can add more attribute for further update
                    };
                    //call uploaduserinfo from database.dart to update user to firestore
                    DatabaseMethods().uploadUserInfo(userInfoMap);
                  }, // edit here
                  // ################## end ######################
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
