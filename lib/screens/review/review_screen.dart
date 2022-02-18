import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/unmatch_provider.dart';
import 'package:loginsystem/widgets/appBar_userreview.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewScreen extends StatelessWidget {
  DatabaseRepository _databaseRepository = DatabaseRepository();
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
              print("Review user click here" + "UserEmail is" + userEmail);
              _showRatingDialog(context);
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
                UnmatchProvider().removeLike(userEmail);
                UnmatchProvider().removeChatroom(FirebaseAuth.instance.currentUser?.email, userEmail);
                Navigator.pushNamed(context, "/realmessageBox");
                            print("Message box !");
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

  void _showRatingDialog(BuildContext context) {
    // actual store listing review & rating
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Is your friend information completed ?',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset("assets/finderlogowall.png"),
      submitButtonText: 'Send',
      commentHint: '1:ไม่ชอบเธอเลย, 2-4:ชอบเธอนะ, 5:ครบถ้วน ',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        _databaseRepository.setRating(response.rating, userEmail);
        // if (response.rating < 3.0) {
        //   // send their comments to your email or anywhere you wish
        //   // ask the user to contact you instead of leaving a bad review
        //   print('three?');
        // } else {
        //   //_rateAndReviewApp();
        // }
        //call db method to add a rating
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}
