import 'package:flutter/material.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/widget.dart';


class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
 
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imageUrls[0],
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 0),
          buildAbout(user),
          
          const SizedBox(height: 48),
          Center(child: buildEditButton(context)),
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
}
