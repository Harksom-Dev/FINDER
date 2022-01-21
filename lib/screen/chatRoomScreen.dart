import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finder_ui/helper/constants.dart';
import 'package:finder_ui/helper/helperfunction.dart';
import 'package:finder_ui/model/database.dart';
import 'package:finder_ui/screen/conversation_screen.dart';
import 'package:finder_ui/screen/search.dart';


class ChatRoom extends StatefulWidget {

  static const String routeName = '/chatRoomScreen';

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
  late Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index){
            return ChatRoomTile(
              snapshot.data.docs[index]["chatroomid"]
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myEmail, ""),
                snapshot.data.docs[index]["chatroomid"]
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
    Constants.myEmail = await HelperFunction.getUserEmailSharedPreference();
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
    return Scaffold(
      appBar:AppBar(title: Text(auth.currentUser.email,style: TextStyle(fontSize: 25)),
      actions: [
          ElevatedButton(
                  child: Text("Sign Out"),
                  onPressed: (){
                      auth.signOut().then((value){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                            return HomeScreen();
                        }));
                      });
                  }, 
                )
        ],),
        body:chatRoomList() ,
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchScreen()
            ));
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