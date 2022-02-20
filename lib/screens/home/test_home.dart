import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/register/register_for_google/register_forgoogle.dart';

class TestHome extends StatelessWidget {
  static const String routeName = '/google login';

  static Route route({
    required String profileName,
    required String profileEmail,
  }) {
    return MaterialPageRoute(
      builder: (_) => TestHome(profileName, profileEmail),
      settings: const RouteSettings(name: routeName),
    );
  }

  final String? profileName;
  final String? profileEmail;


  const TestHome(String this.profileName, this.profileEmail, {Key? key}) : super(key: key);

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
            return RegisterScreenForGoogle(profileName, profileEmail);
          }
          else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }
          else {//todo must be logout
            return FirstAuth();
          }
        },
      ),
    );
  }
}