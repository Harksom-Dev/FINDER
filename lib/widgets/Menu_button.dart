import 'package:flutter/material.dart';

class Menubutton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final bool hasGradient;
  final IconData icon;

  const Menubutton({
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
        color: Colors.white,
        /*boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(50),
          spreadRadius: 6,
          blurRadius: 4,
          offset: Offset(3, 3),
        ),
      ] */
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
