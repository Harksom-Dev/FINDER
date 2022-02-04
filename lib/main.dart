import 'package:loginsystem/blocs/swipe/swipe_bloc.dart'
    show LoadUsersEvent, SwipeBloc;
import 'package:loginsystem/config/app_router.dart';
import 'package:loginsystem/config/theme.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/screens/home/first_auth.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:loginsystem/screens/test/test.dart';
import 'package:loginsystem/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/screens/messagebox/chatroom_screen.dart';

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
    getUser();// get all user and convert to list

    
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunction.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
    
  }

  //get all user and minus current login user
  getUser() async {
    String email = await HelperFunction.getUserEmailSharedPreference();
    userlist  = await _databaseRepository.usertoList();
    User.set(userlist,email);
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc(databaseRepository: DatabaseRepository())..add(LoadUsersEvent(users: User.users)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute:  userIsLoggedIn ? HomeScreen.routeName : first_auth.routeName,
        // home: const StreamBuilderTest(),    //tempory page to check about database
      ),
      // home: userIsLoggedIn ? ChatRoom() : HomeScreen()
    );
  }
}

