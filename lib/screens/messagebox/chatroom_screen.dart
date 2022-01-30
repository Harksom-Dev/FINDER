import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/helper/helperfunction.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/screens/chat/conversation_screen.dart';
import 'package:loginsystem/screens/messagebox/search.dart';


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
  DatabaseRepository _databaseRepository = new DatabaseRepository();
  Stream? chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder<dynamic>(
      stream: chatRoomStream,           
      builder: (context,snapshot){
        
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            return ChatRoomTile(
              snapshot.data!.docs[index]["chatroomid"]
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myEmail, ""),
                snapshot.data!.docs[index]["chatroomid"]
            );
          }) : Container();
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
    databaseMethods.getChatRoom(Constants.myEmail).then((value){
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
      var user = auth.currentUser!.email;
    return Scaffold(
      // ignore: prefer_const_constructors
      
      appBar:AppBar(title: Text(user!,style: TextStyle(fontSize: 25)),
      actions: [
          ElevatedButton(
                  child: Text("Sign Out"),
                  onPressed: (){
                      auth.signOut().then((value){
                        // Navigator.pushReplacement(context,
                        // MaterialPageRoute(builder: (context){
                        //     return HomeScreen();
                        // }));
                        Navigator.pushNamed(context, "/first");
                          print("first auth!");
                      });
                  }, 
                )
        ],),
        body:chatRoomList() ,
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
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
  ChatRoomTile(this.userEmail,this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
          ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userEmail.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(width: 8,),
            Text(userEmail)
          ],
        ),
      ),
    );
  }
}