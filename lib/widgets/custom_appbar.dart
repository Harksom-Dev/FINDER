import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/finderlogoColorSmall.png",
            width: 120,
            height: 40,
          ),
          /* Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("DISCOVER", style: Theme.of(context).textTheme.headline1),
            ],
          ), */
          /* SizedBox(
            width: 10,
          ), */
          IconButton(
              icon: Icon(Icons.person, color: Color(0xFFF101010)),
              onPressed: () {
                Navigator.pushNamed(context, "/profile");
              })
        ],
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFF9FAFE),
                Color(0xFFF9FAFE),
              ]),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
