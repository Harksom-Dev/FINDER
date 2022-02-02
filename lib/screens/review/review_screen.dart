import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loginsystem/widgets/appBar_userreview.dart';

class ReviewScreen extends StatelessWidget {
  static const String routeName = '/review';
  static Route route({required String userEmail}) {
    return MaterialPageRoute(
      builder: (context) => ReviewScreen(userEmail),
      settings: RouteSettings(name: routeName),
    );
  }

  final String userEmail;
  ReviewScreen(this.userEmail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFE),
      appBar: UserReviewAppbar(
        userEmail: userEmail,
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    userEmail.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Text(
                userEmail.toUpperCase(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("Review user click here");
            },
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFF594B7),
                    Color(0xFF92B2FD),
                    Color(0xFFC3CDF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Text(
                "Review User",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                print("UnMatch was click");
              },
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Text(
                  "Unmatch",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              )),
        ],
      )),
    );
  }
}
