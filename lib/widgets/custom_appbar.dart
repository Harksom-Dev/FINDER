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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              //flex: 2,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("DISCOVER", style: Theme.of(context).textTheme.headline1),
            ],
          ))
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.person, color: Color(0xFFF101010)),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            })
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
