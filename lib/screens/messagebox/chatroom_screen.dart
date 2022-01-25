import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/screens/chat/conversation_screen.dart';
import 'package:loginsystem/screens/messagebox/search.dart';
import 'package:loginsystem/widgets/Menu_button.dart';

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

  Widget chatRoomList() {
    print("Chat room has call");
    return StreamBuilder<dynamic>(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        snapshot.data!.docs[index]["chatroomid"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(Constants.myEmail, ""),
                        snapshot.data!.docs[index]["chatroomid"]);
                  })
              : Container();
          print("Hello");
        });
  }

  Widget MenuTab() {
    return Container(
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
                Navigator.pushNamed(context, "/realmessageBox");
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
    );
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
        //title: Text("Chats", style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                //flex: 2,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chats", style: Theme.of(context).textTheme.headline2),
              ],
            ))
          ],
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 0.0,
              ),
              child: Text(
                'Messages',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Column(
              children: [
                chatRoomList(),
              ],
            ),
            Column(
              children: [
                MenuTab(),
              ],
            ),
          ],
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              child: Text("${userEmail.substring(0, 1).toUpperCase()}"),
            ),
            SizedBox(
              width: 8,
            ),
            Text(userEmail)
          ],
        ),
      ),
    );
  }
  /* 
  
  
  */
}
