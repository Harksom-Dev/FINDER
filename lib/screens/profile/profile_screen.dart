import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'dart:async';

import '../../widgets/button_editprofile.dart';
import '../../widgets/profileAppbar.dart';
import '../../widgets/profile_editprofile.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseRepository _databaseRepository = DatabaseRepository();
  User? userFromDB = User.dummyUser;
  bool _isLoading = true;
  double rating = 0;
  int n = 0;

  @override
  void initState() {
    getData();

    super.initState();

    Timer(Duration(milliseconds: 3000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final User user = User.users[0];
    //print(user);
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: const CircularProgressIndicator(
            color: Colors.pink,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                    icon: Icon(Icons.logout_rounded, color: Color(0xFFF101010)),
                    onPressed: () {
                      auth.FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushNamed(context, "/first");
                        print("first auth!");
                      });
                    }),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            ProfileWidget(
              imagePath: userFromDB?.imageUrls[0],
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(userFromDB!),
            const SizedBox(height: 0),
            buildAbout(userFromDB!),
            const SizedBox(height: 48),
            Center(child: buildEditButton(context)),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Review',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < n; i++)
                        CustomTextContainer(text: userFromDB?.interested[i]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildEditButton(BuildContext context) => ButtonWidget(
        text: 'Edit Profile',
        onClicked: () {
          Navigator.pushNamed(context, "/editprofile");
        },
      );

  Widget buildreview(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildinterest(User user) => Container();

  Future getData() async {
    print("perfrom getdata");
    await DatabaseRepository()
        .getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email)
        .then((userData) {
      print("before set userFromDB = $userData");
      userFromDB = userData;
      print("userFromDB = $userFromDB");
    });
    await _databaseRepository
        .getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email)
        .then((userData) => n = User.userInterested.length);

    await _databaseRepository.getUserRating().then((rated) => {
          rating = rated,
        });

    print(n);
  }
}

class CustomTextContainer extends StatelessWidget {
  final String text;

  const CustomTextContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 5,
      ),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
