import 'dart:async';
import 'dart:ui';

import 'package:loginsystem/blocs/swipe/swipe_bloc.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/custom_appbar.dart';
import 'package:loginsystem/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginsystem/widgets/choice_button.dart';
import 'package:loginsystem/widgets/Menu_button.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  bool _isLoading = true;
  @override
  void initState() {
    _databaseRepository.userLikedAndDisliked();
    BlocProvider.of<SwipeBloc>(context).add(LoadUsersEvent(users: User.users));
    //sprint(User.users);
    /* if (User.isdislikeclear) {
      _databaseRepository.cleardislike();
    } */
    super.initState();
    //Using Timer
    Timer(Duration(milliseconds: 900), () {
      setState(() {
        _isLoading = false;
      });
    });
    //Future.delayed
    Future.delayed(Duration(milliseconds: 900), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          final maxWid = MediaQuery.of(context).size.width;
          // which ui to render
          if (state is SwipeLoading) {
            print("i am superman, i am loading progress");
            // if we at the
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            // suggest();
            // swipe loaded state
            if (_isLoading) {
              return Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: const CircularProgressIndicator(
                    color: Colors.pink,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            } else {
              if (state.users.length != 0 && state.users[0] != null) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                        ]),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onDoubleTap: () async {
                          Navigator.pushNamed(context, '/users',
                              arguments: state.users[0]);
                        },
                        child: Draggable<User>(
                          axis: Axis.horizontal,
                          data: state.users[0],
                          child: UserCard(user: state.users[0]),
                          feedback: UserCard(user: state.users[0]),
                          //childWhenDragging: UserCard(user: state.users[1]),
                          childWhenDragging: UserCard(
                              user: state.users.length == 1
                                  ? state.users[0]
                                  : state.users[1]),
                          onDragEnd: (drag) {
                            if (drag.velocity.pixelsPerSecond.dx <
                                -0.4 * maxWid) {
                              context.read<SwipeBloc>()
                                ..add(SwipeLeftEvent(user: state.users[0]));
                              print("swipe left");
                            } else if (drag.velocity.pixelsPerSecond.dx >
                                0.6 * maxWid) {
                              context.read<SwipeBloc>()
                                ..add(SwipeRightEvent(user: state.users[0]));
                              print('Swipe Right');
                            } else {
                              print('Do nothing');
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              // button
                              onTap: () {
                                // cross button (X)
                                context.read<SwipeBloc>()
                                  ..add(SwipeLeftEvent(user: state.users[0]));
                                print("swipe left");
                              },
                              child: ChoiceButton(
                                  width: 60,
                                  height: 60,
                                  hasGradient: false,
                                  color: Colors.white,
                                  icon: Icons.clear_rounded,
                                  size: 25),
                            ),
                            InkWell(
                              // like button
                              onTap: () {
                                context.read<SwipeBloc>()
                                  ..add(SwipeRightEvent(user: state.users[0]));
                                print("swipe Right");
                              },
                              child: ChoiceButton(
                                  width: 74,
                                  height: 74,
                                  hasGradient: true,
                                  color: Colors.white,
                                  icon: Icons.favorite,
                                  size: 30),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                                  /* Navigator.pushNamed(context, "/"); */
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
                                  Navigator.pushNamed(
                                      context, "/realmessageBox");
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
                      ),
                    ],
                  ),
                );
              } else {
                //
                //
                //
                // #### OUT OF USER CHECK ################################
                //
                //
                //
                print("Out Of User");
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                          Color(0xFFF9FAFE),
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black12,
                          ),
                          height: MediaQuery.of(context).size.height / 1.6,
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Out Of User",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  await new Future.delayed(
                                      const Duration(seconds: 1));
                                  Navigator.pushNamed(context, "/");
                                },
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    //color: Color(0xFFE29AC4),
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.black26),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: const [
                                          Color(0xFFF9851F),
                                          Color(0xFFDF8F49),
                                          Color(0xFFDF8F49),
                                        ]),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Reload",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 60,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                // button
                                onTap: () {
                                  // cross button (X)
                                  context.read<SwipeBloc>()
                                    ..add(SwipeLeftEvent(user: state.users[0]));
                                  print("swipe left");
                                },
                                child: ChoiceButton(
                                    width: 60,
                                    height: 60,
                                    hasGradient: false,
                                    color: Colors.white,
                                    icon: Icons.clear_rounded,
                                    size: 25),
                              ),
                              InkWell(
                                // like button
                                onTap: () {
                                  context.read<SwipeBloc>()
                                    ..add(
                                        SwipeRightEvent(user: state.users[0]));
                                  print("swipe Right");
                                },
                                child: ChoiceButton(
                                    width: 74,
                                    height: 74,
                                    hasGradient: true,
                                    color: Colors.white,
                                    icon: Icons.favorite,
                                    size: 30),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                    Navigator.pushNamed(
                                        context, "/realmessageBox");
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
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }
          return CircularProgressIndicator();
          /* else {
            return Text("Something Went Wrong");
          } */
        },
      ),
    );
  }
}
