import 'package:finder_ui/blocs/swipe/swipe_bloc.dart';
import 'package:finder_ui/config/theme.dart';
import 'package:finder_ui/models/user_model.dart';
import 'package:finder_ui/widgets/custom_appbar.dart';
import 'package:finder_ui/widgets/user_card.dart';
import 'package:finder_ui/widgets/user_image_small.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finder_ui/widgets/choice_button.dart';
import 'package:finder_ui/widgets/Menu_button.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          // which ui to render
          if (state is SwipeLoading) {
            // if we at the
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            // swipe loaded state
            return Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    Navigator.pushNamed(context, '/users',
                        arguments: state.users[0]);
                  },
                  child: Draggable<User>(
                    data: state.users[0],
                    child: UserCard(user: state.users[0]),
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: UserCard(user: state.users[1]),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context.read<SwipeBloc>()
                          ..add(SwipeLeftEvent(user: state.users[0]));
                        print("swipe left");
                      } else {
                        context.read<SwipeBloc>()
                          ..add(SwipeRightEvent(user: state.users[0]));
                        print('Swipe Right');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(90),
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              color: Colors.black,
                              icon: Icons.home,
                              size: 25),
                        ),
                        InkWell(
                          // home
                          onTap: () {
                            Navigator.pushNamed(context, "/messagebox");
                            print("Message box !");
                          },
                          child: Menubutton(
                              width: 50,
                              height: 50,
                              hasGradient: false,
                              color: Colors.black,
                              icon: Icons.messenger_sharp,
                              size: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Text("Something Went Wrong");
          }
        },
      ),
    );
  }
}
