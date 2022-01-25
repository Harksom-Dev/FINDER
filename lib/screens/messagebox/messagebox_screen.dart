import 'package:flutter/material.dart';

class MessageBoxScreen extends StatelessWidget {
  static const String routeName = '/messagebox';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => MessageBoxScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Messages"),
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
            child: Text("🏠"),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ElevatedButton(
            child: Text("Example Chat"),
            onPressed: () {
              Navigator.pushNamed(context, "/chat");
            },
          )
        ],
      )),
    );
  }
}
