import 'package:finder_ui/config/theme.dart';
import 'package:finder_ui/models/user_model.dart';
import 'package:finder_ui/widgets/custom_appbar.dart';
import 'package:finder_ui/widgets/user_card.dart';
import 'package:finder_ui/widgets/user_image_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
          child: Column(
        children: [
          UserCard(user: User.users[0]),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceButton(
                    width: 60,
                    height: 60,
                    hasGradient: false,
                    color: Colors.white,
                    icon: Icons.clear_rounded,
                    size: 25),
                ChoiceButton(
                    width: 70,
                    height: 70,
                    hasGradient: true,
                    color: Colors.white,
                    icon: Icons.favorite,
                    size: 30),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final bool hasGradient;
  final IconData icon;

  const ChoiceButton({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.hasGradient,
    required this.icon,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          gradient: hasGradient
              ? LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.purple,
                    Colors.red,
                  ],
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 6,
              blurRadius: 4,
              offset: Offset(3, 3),
            ),
          ]),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
