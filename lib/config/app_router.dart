import 'package:finder_ui/models/models.dart';
import 'package:finder_ui/screens/chat/chat_screen.dart';
import 'package:finder_ui/screens/edit_profile/editprofile_screen.dart';
import 'package:finder_ui/screens/home/home_screen.dart';
import 'package:finder_ui/screens/messagebox/messagebox_screen.dart';
import 'package:finder_ui/screens/profile/profile_screen.dart';
import 'package:finder_ui/screens/review/review_screen.dart';
import 'package:finder_ui/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings setting) {
    print("the route is: ${setting.name}");

    switch (setting.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case EditProfileScreen.routeName:
        return EditProfileScreen.route();
      case MessageBoxScreen.routeName:
        return MessageBoxScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route();
      case ReviewScreen.routeName:
        return ReviewScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: setting.arguments as User);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text("Error")),
      ),
      settings: RouteSettings(name: '/error'),
    );
  }
}
