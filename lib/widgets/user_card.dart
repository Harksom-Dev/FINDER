import 'package:loginsystem/models/user_model.dart';
import 'package:loginsystem/widgets/user_image_small.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> dupList = sameInterest(User.userInterested, user.interested);
    return Hero(
      tag: 'user_image',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            width: MediaQuery.of(context).size.width / 1.05,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.imageUrls[0]),
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(3, 3),
                        ),
                      ]),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.name}, ${user.age}',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        '${user.bio}',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
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
                                      borderRadius: BorderRadius.circular(20),
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
                      /*Row(
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
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  sameInterest(List<String> cUser, List<dynamic> oUser) {
    List dupInterest = [];
    List dump = [];
    oUser.forEach((data) {
      if (cUser.contains(data)) {
        dupInterest.add(data);
      } /* else {
        dump.add(data);
      } */
    });
    //dupInterest.addAll(dump);
    return dupInterest;
  }
}
