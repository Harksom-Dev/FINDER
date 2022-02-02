import 'package:loginsystem/models/models.dart';
import 'package:loginsystem/screens/home/test_home.dart';
import 'package:loginsystem/screens/messagebox/chatroom_screen.dart';
import 'package:loginsystem/screens/chat/conversation_screen.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/profile/login.dart';
import 'package:loginsystem/screens/profile/register.dart';
import 'package:loginsystem/screens/messagebox/search.dart';
import 'package:loginsystem/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings setting) {
    print("the route is: ${setting.name}");

    switch (setting.name) {
      case '/':
        return HomeScreen.route(); //swipe screen for now
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case EditProfileScreen.routeName:
        return EditProfileScreen.route();
      case MessageBoxScreen.routeName:
        return MessageBoxScreen.route();
      case ChatScreen.routeName: //chatroom_screen(real message box)
        return ChatScreen.route();
      case ReviewScreen.routeName:
        return ReviewScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: setting.arguments as User);
      case ConversationScreen.routeName: //chatroom
        return ConversationScreen.route(
            chatroomId: setting.arguments as String,
            userEmail: setting.arguments
                as String); // trying to pass a value through route
      case LoginScreen.routeName: // login
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case SearchScreen.routeName:
        return SearchScreen.route();
      case FirstAuth.routeName:
        return FirstAuth.route();
      case ChatRoom.routeName:
        return ChatRoom.route();
      case TestHome.routeName:
        return TestHome.route();
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
