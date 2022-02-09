import 'package:loginsystem/blocs/swipe/swipe_bloc.dart'
    show LoadUsersEvent, SwipeBloc;
import 'package:loginsystem/config/app_router.dart';
import 'package:loginsystem/config/theme.dart';
import 'package:loginsystem/provider/google_sign_in.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:loginsystem/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/screens/messagebox/chatroom_screen.dart';
import 'firebase_options.dart';

void main() {
  runApp(MyApp());
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
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        BlocProvider(
          create: (context) =>
              SwipeBloc()..add(LoadUsersEvent(users: User.users)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute:
            userIsLoggedIn ? HomeScreen.routeName : FirstAuth.routeName,
        //initialRoute: userIsLoggedIn ? HomeScreen.routeName : first_auth.routeName,
      ),
      // home: userIsLoggedIn ? ChatRoom() : HomeScreen()
    );
  }
}
