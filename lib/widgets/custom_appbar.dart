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
      title: Row(
        children: [
          Expanded(
            child: Image.asset(
              "assets/icon/logo.png",
              height: 120,
            ),
          ),
          Expanded(
              flex: 2,
              child: Text("DISCOVER",
                  style: Theme.of(context).textTheme.headline2))
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.person, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            })
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
