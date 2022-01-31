import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInWidget extends StatelessWidget {

  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('profile', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 32),
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              radius: 40,
            ),
            const SizedBox(height: 8),
            Text('Logged in as: ${user.displayName}'),
            Text('email in as: ${user.email}'),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/first');
              },
            ),
          ],
        ),
      ),
    );
  }
}