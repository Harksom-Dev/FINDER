import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/screens/edit_profile/editprofile_interest.dart';
import 'package:loginsystem/screens/home/test_home.dart';
import 'package:loginsystem/screens/messagebox/chatroom_screen.dart';
import 'package:loginsystem/screens/chat/conversation_screen.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/profile/login.dart';
import 'package:loginsystem/screens/register/register.dart';
import 'package:loginsystem/screens/messagebox/search.dart';
import 'package:loginsystem/screens/register/register_2.dart';
import 'package:loginsystem/screens/register/register_for_google/register_2_forgoogle.dart';
import 'package:loginsystem/screens/register/register_for_google/register_forgoogle.dart';
import 'package:loginsystem/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/screens/edit_profile/uploadpicture.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings setting) {
    print("the route is: ${setting.name}");

    switch (setting.name) {
      //swipe screen for now
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case EditProfileScreen.routeName:
        return EditProfileScreen.route();
      case MessageBoxScreen.routeName:
        return MessageBoxScreen.route();
      case ReviewScreen.routeName:
        return ReviewScreen.route(userEmail: setting.arguments as String);
      case UsersScreen.routeName:
        return UsersScreen.route(user: setting.arguments as User);
      case UploadPicture.routeName:
        return UploadPicture.route();
      case Editprofile_interest.routeName:
        return Editprofile_interest.route(
            UpdateName: setting.arguments as String,
            UpdateBio: setting.arguments as String,
            UpdateInterest: setting.arguments as List<String>,
            updateEmail: setting.arguments as String,
            updateimageURL: setting.arguments as String);

      case ConversationScreen.routeName: //chatroom
        return ConversationScreen.route(
            chatroomId: setting.arguments as String,
            userEmail: setting.arguments
                as String); // trying to pass a value through route
      case LoginScreen.routeName: // login
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case RegisterInterestScreen.routeName:
        return RegisterInterestScreen.route(
          profileName: setting.arguments as String,
          profileEmail: setting.arguments as String,
          dob: setting.arguments as String,
          profilePassword: setting.arguments as String,
          profileInterest: setting.arguments as List<String>,
        );
      case SearchScreen.routeName:
        return SearchScreen.route();
      case FirstAuth.routeName:
        return FirstAuth.route();
      case ChatRoom.routeName:
        return ChatRoom.route();
      case TestHome.routeName:
        return TestHome.route(
          profileName: setting.arguments as String,
          profileEmail: setting.arguments as String,
        );
      case RegisterInterestScreenForGoogle.routeName:
        return RegisterInterestScreenForGoogle.route(
          profileName: setting.arguments as String,
          profileEmail: setting.arguments as String,
          dob: setting.arguments as String,
          profileInterest: setting.arguments as List<String>,
        );

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
