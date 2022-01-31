import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/widgets/auth/logged_in_widget.dart';

class TestHome extends StatelessWidget {
  static const String routeName = '/google login';

  const TestHome({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TestHome(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData) {
            return const LoggedInWidget();
          }
          else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }
          else {//todo must be logout
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}