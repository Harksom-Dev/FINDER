import 'package:flutter/material.dart';
import 'package:loginsystem/widgets/Menu_button.dart';

class menutab extends StatelessWidget {
  const menutab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xFFF101010),
      ),
      height: 65,
      width: MediaQuery.of(context).size.width / 1.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 60,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              // home
              onTap: () {
                // cross button (X)
                Navigator.pushNamed(context, "/");
                print("homepage !");
              },
              child: Menubutton(
                  width: 50,
                  height: 50,
                  hasGradient: false,
                  color: Colors.white,
                  icon: Icons.home,
                  size: 25),
            ),
            InkWell(
              // home
              onTap: () {
                Navigator.pushNamed(context, "/realmessageBox");
                print("Message box !");
              },
              child: Menubutton(
                  width: 50,
                  height: 50,
                  hasGradient: false,
                  color: Colors.white,
                  icon: Icons.message_rounded,
                  size: 25),
            ),
          ],
        ),
      ),
    );
  }
}
