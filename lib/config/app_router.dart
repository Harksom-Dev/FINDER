import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/screen/conversation_screen.dart';
import 'package:loginsystem/screen/first_auth.dart';
import 'package:loginsystem/screen/login.dart';
import 'package:loginsystem/screen/register.dart';
import 'package:loginsystem/screen/search.dart';
import 'package:loginsystem/screen/welcome.dart';
import 'package:loginsystem/screens/chat/chat_screen.dart';
import 'package:loginsystem/screens/edit_profile/editprofile_screen.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:loginsystem/screens/messagebox/messagebox_screen.dart';
import 'package:loginsystem/screens/profile/profile_screen.dart';
import 'package:loginsystem/screens/review/review_screen.dart';
import 'package:loginsystem/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings setting) {
    print("the route is: ${setting.name}");

    switch (setting.name) {
      case '/':
        return HomeScreen.route();  //swipe screen for now
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName: 
        return ProfileScreen.route();
      case EditProfileScreen.routeName:
        return EditProfileScreen.route();
      case MessageBoxScreen.routeName:
        return MessageBoxScreen.route();
      case ChatScreen.routeName:  //chatroom_screen(real message box)
        return ChatScreen.route();
      case ReviewScreen.routeName:
        return ReviewScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: setting.arguments as User);
      case WelcomeScreen.routeName:
        return WelcomeScreen.route(); //main login 
      case ConversationScreen.routeName:  //chatroom
        return ConversationScreen.route(chatroomId : setting.arguments as String); // trying to pass a value through route
      case LoginScreen.routeName: // login
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case SearchScreen.routeName:
        return SearchScreen.route();
      case first_auth.routeName:
        return first_auth.route();
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
