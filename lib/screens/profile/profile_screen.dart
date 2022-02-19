import 'package:flutter/material.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/widget.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'dart:async';

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

  User? userFromDB = User.dummyUser;


  @override
    void initState() {
      getData();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    // final User user = User.users[0];

    DatabaseRepository _databaseRepository = DatabaseRepository();
    //print(user);
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _databaseRepository.getUserRating().toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextContainer(text: userFromDB!.interested[0]),
                    CustomTextContainer(text: userFromDB!.interested[1]),
                    CustomTextContainer(text: userFromDB!.interested[1]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
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
          borderRadius: BorderRadius.circular(5),
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
