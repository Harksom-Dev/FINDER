import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  static const String routeName = '/review';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ReviewScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: Text(" < "),
            onPressed: () {
              Navigator.pushNamed(context, "/chat");
            },
          ),
        ],
      )),
    );
  }
}
