import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/config/theme.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream? chatRoomStream;
  ScrollController _scrollController = ScrollController();

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
                height: 60,
                child: Container(
                  // match person replace here
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFFF), // white background
                  ),
                ),
              ), // end of match person section
              Text("Messages", style: Theme.of(context).textTheme.headline2),
              SizedBox(
                // message list
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.7,
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
                  // Navigator.pushReplacement(context,
                  // MaterialPageRoute(builder: (context){
                  //     return HomeScreen();
                  // }));
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
}

class ChatRoomTile extends StatelessWidget {
  final String userEmail;
  final String chatRoomId;
  ChatRoomTile(this.userEmail, this.chatRoomId);
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*_scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut); */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(chatRoomId, userEmail)));
      },
      child: Container(
        color: Colors.black26,
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
