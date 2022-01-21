import 'package:finder_ui/blocs/swipe/swipe_bloc.dart'
    show LoadUsersEvent, SwipeBloc;
import 'package:finder_ui/config/app_router.dart';
import 'package:finder_ui/config/theme.dart';
import 'package:finder_ui/screens/home/home_screen.dart';
import 'package:finder_ui/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/screen/chatRoomScreen.dart';
import 'package:loginsystem/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    Firebase.initializeApp();
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunction.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
      ),
      home: userIsLoggedIn ? ChatRoom() : HomeScreen()
    );
  }
}

