import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/editprofile';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => EditProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(" < "),
          onPressed: () {
            Navigator.pushNamed(context, "/profile");
          },
        ),
      ),
    );
  }
}
