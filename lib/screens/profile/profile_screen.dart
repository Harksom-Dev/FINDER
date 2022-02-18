import 'package:flutter/material.dart';
import 'package:loginsystem/models/database_repository.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  DatabaseRepository _databaseRepository = DatabaseRepository();
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: Text(" < "),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ElevatedButton(
            child: Text(" Edit Profile "),
            onPressed: () {
              Navigator.pushNamed(context, "/editprofile");
              //this function will return a double of rating of current user
              // _databaseRepository.getUserRating();
            },
          )
        ],
      )),
    );
  }
}
