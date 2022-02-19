import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/match_data_model.dart';
import 'package:loginsystem/provider/matching_provider.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/screens/chat/conversation_screen.dart';
import 'package:loginsystem/screens/messagebox/search.dart';
import 'package:loginsystem/widgets/widget.dart';

// ignore: use_key_in_widget_constructors
class ChatRoom extends StatefulWidget {
  static const String routeName = '/realmessageBox';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChatRoom(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final auth = Auth.FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final MatchingProvider _matchingProvider = new MatchingProvider();
  DatabaseRepository _databaseRepository = new DatabaseRepository();
  Stream? chatRoomStream;
  Stream? matchedStream;
  final ScrollController _scrollController = ScrollController();
  late MatchData matchList;

  Widget chatRoomList() {
    return StreamBuilder<dynamic>(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Text("Match!", style: Theme.of(context).textTheme.headline2),
              SizedBox(
                // here is where match person is
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: StreamBuilder<dynamic>(
                    stream: matchedStream,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: <Widget>[
                                snapshot.hasData
                                    ? ListView.builder(
                                        itemCount: snapshot
                                            .data!.docs[0]['matchWith'].length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: Row(
                                              children: [
                                                UserMatchTile(
                                                    snapshot.data!
                                                        .docs[index]["email"]
                                                        .toString(),
                                                    snapshot.data!.docs[0]
                                                        ["name"],
                                                    snapshot.data!.docs[0]
                                                        ["matchWith"][index]),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    // match person replace here

                    ),
              ), // end of match person section
              Text("Messages", style: Theme.of(context).textTheme.headline2),
              SizedBox(
                // message list
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.78,
                child: Stack(children: [
                  snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  ChatRoomTile(
                                      snapshot.data!.docs[index]["chatroomid"]
                                          .toString()
                                          .replaceAll("_", "")
                                          .replaceAll(Constants.myEmail, ""),
                                      snapshot.data!.docs[index]["chatroomid"]),
                                ],
                              ),
                            );
                          })
                      : Container(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: menutab(),
              ), //  button
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    getMatchedData();
    //initMatch(_databaseRepository.getUserByEmail(Constants.myEmail));
    super.initState();
  }

  getUserInfo() async {
    Constants.myEmail = (await HelperFunction.getUserEmailSharedPreference());
    databaseMethods.getChatRoom(Constants.myEmail).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  getMatchedData() async {
    databaseMethods.getMatchdata(Constants.myEmail).then((value) {
      setState(() {
        matchedStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = auth.currentUser!.email;
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Chats", style: Theme.of(context).textTheme.headline2),
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.logout_rounded, color: Color(0xFFF101010)),
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, "/first");
                  print("first auth!");
                });
              })
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(context, "/search");
          print("searching");
        },
      ),
    );
  }

  //TODO: implement MatchData List
/*   Future<void> initMatch(Future<User?> user) async {
    _matchingProvider
        .getMatchedDataByUser(user)
        .then((data) => matchList = data);
  } */
  //// please be easy
}

class ChatRoomTile extends StatelessWidget {
  final String userEmail;
  final String chatRoomId;
  ChatRoomTile(this.userEmail, this.chatRoomId);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId, userEmail)),
        );
        /*Navigator.pushNamed(context, "/realchat",
            arguments: {chatRoomId, userEmail});*/
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 61,
              width: 61,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFF69090),
                  borderRadius: BorderRadius.circular(40)),
              child: Text("${userEmail.substring(0, 1).toUpperCase()}"),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userEmail,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

class UserMatchTile extends StatelessWidget {
  final String userEmail;
  final String userName;
  final Map<String, dynamic> matchwith;
  String name = '';
  UserMatchTile(this.userEmail, this.userName, this.matchwith);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ConversationScreen(chatRoomId, userEmail)),
        // );
        var otherid =
            matchwith['id']; // get other id from map that we get from firebase
        String otheremail = MatchingProvider().getMatchedEmail(
            otherid); //get otheremail with func from match_provider
        //now we need to check if we already have a chatroom because right now if 2person that have first letter name similar gonna have a bug
        String chatRoomId =
            MatchingProvider().checkChatRoomID(otheremail, userEmail);
        if (chatRoomId == '') {
          //if this the first time we create a new chatroom
          chatRoomId = getChatRoomId(otheremail, userEmail);
        }

        List<String> users = [otheremail, userEmail];
        Map<String, dynamic> chatRoomMap = {
          "users": users,
          "chatroomid": chatRoomId
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
        //hope this work!!
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId, otheremail)),
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 61,
              width: 61,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFF69090),
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                  "${userName.substring(0, 1).toUpperCase()}"), //this child will show the name or thumbnail
            ),
          ],
        ),
      ),
    );
  }

  // create chatroom, send user to conversation screen,pushreplacement
  createChatroomAndStartConversation({required String userEmail}) {
    //so long function name ;-;
    // print(Constants);
    var otherid = matchwith['id'];
    String otheremail = MatchingProvider().getMatchedEmail(otherid);
    String chatRoomId = getChatRoomId(otheremail, userEmail);
    List<String> users = [otheremail, userEmail];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomid": chatRoomId
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ConversationScreen(chatRoomId, otheremail)),
    //   );
  }

  getChatRoomId(String a, String b) {
    print(a);
    print(b);
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
