import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final bool hasGradient;
  final IconData icon;

  const ChoiceButton({
    Key? key,
    this.width = 60,
    this.height = 60,
    required this.color,
    this.hasGradient = false,
    required this.icon,
    this.size = 25,
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
                    Color(0xFFFF594B7),
                    Color(0xFFFAD7FFB),
                  ],
                )
              : LinearGradient(
                  colors: [
                    Color(0xFFFAD7FFB),
                    Color(0xFFF92B2FD),
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
