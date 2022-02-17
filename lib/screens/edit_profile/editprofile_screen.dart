import 'package:flutter/material.dart';
import 'package:loginsystem/models/user_model.dart';
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
            onClicked: () async {Navigator.pushNamed(context, "/uploadPicture");},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: user.name,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.bio,
            maxLines: 3,
            onChanged: (about) {},
          ),
        ],
      ),
    );
  }
}
