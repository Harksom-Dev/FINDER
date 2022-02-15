import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:loginsystem/blocs/swipe/swipe_bloc.dart'
    show LoadUsersEvent, SwipeBloc;
import 'package:loginsystem/config/app_router.dart';
import 'package:loginsystem/config/theme.dart';
import 'package:loginsystem/provider/google_sign_in.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginsystem/helper/helperfunction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> userlist = [];
  bool userIsLoggedIn = false;
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  @override
  void initState() {
    // Firebase.initializeApp();
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = auth.FirebaseAuth.instance.currentUser != null;
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
          create: (_) => SwipeBloc(databaseRepository: DatabaseRepository())..add(LoadUsersEvent(users: User.users)),
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
