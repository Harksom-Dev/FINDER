import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginsystem/blocs/swipe/swipe_bloc.dart';
import 'package:loginsystem/config/theme.dart';
import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/choice_button.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/widgets/user_image_small.dart';
import 'package:provider/src/provider.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      builder: (context) => UsersScreen(user: user),
      settings: RouteSettings(name: routeName),
    );
  }

  final User user;
  const UsersScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    List<dynamic> dupList = sameInterest(User.userInterested, user.interested);
    List<dynamic> diffList = diffInterest(User.userInterested, user.interested);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Hero(
                          tag: 'user_image',
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    image: NetworkImage(user.imageUrls[0]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<SwipeBloc>()
                                    ..add(SwipeLeftEvent(user: state.users[0]));
                                  Navigator.of(context).pop();
                                  print("swipe left");
                                },
                                child: ChoiceButton(
                                  height: 60,
                                  width: 60,
                                  size: 30,
                                  hasGradient: false,
                                  color: Colors.white,
                                  icon: Icons.clear_rounded,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<SwipeBloc>()
                                    ..add(
                                        SwipeRightEvent(user: state.users[0]));
                                  Navigator.of(context).pop();
                                  print("swipe Right");
                                },
                                child: ChoiceButton(
                                  height: 74,
                                  width: 74,
                                  size: 30,
                                  hasGradient: true,
                                  color: Colors.white,
                                  icon: Icons.favorite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name}, ${user.age}',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        '${user.bio}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(height: 2),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      /* Text(
                        'Interest',
                        style: Theme.of(context).textTheme.headline3,
                      ), */
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: dupList
                                  .map(
                                    (interest) => Container(
                                      padding: const EdgeInsets.all(6.0),
                                      margin: const EdgeInsets.only(
                                          top: 5.0, right: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFFF594B7),
                                            Color(0xFFB6CBFE),
                                          ])),
                                      child: Text(
                                        interest,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: diffList
                                  .map(
                                    (diffin) => Container(
                                      padding: const EdgeInsets.all(6.0),
                                      margin: const EdgeInsets.only(
                                          top: 5.0, right: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(colors: [
                                            Colors.black26,
                                            Colors.black26,
                                          ])),
                                      child: Text(
                                        diffin,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          UserImageSmall(imageUrl: user.imageUrls[1]),
                          UserImageSmall(imageUrl: user.imageUrls[2]),
                          SizedBox(width: 150),

                          /*Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                                child: Container(
                                  width: 25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 25,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ), 
                                ),
                              )*/
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  sameInterest(List<String> cUser, List<dynamic> oUser) {
    List dupInterest = [];
    oUser.forEach((data) {
      if (cUser.contains(data)) dupInterest.add(data);
    });
    return dupInterest;
  }

  diffInterest(List<String> cUser, List<dynamic> oUser) {
    List diff = [];
    oUser.forEach((data) {
      if (cUser.contains(data)) {
        // do nothing
      } else {
        diff.add(data);
      }
    });
    return diff;
  }
}
