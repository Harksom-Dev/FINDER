
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/model/database.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/realmessagebox';

  static Route route({required String chatroomId}) {
    return MaterialPageRoute(
      builder: (context) => ConversationScreen(chatroomId),  // not sure
      settings: RouteSettings(name: routeName),
    );
  }
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  late Stream chatMessageStream;

  Widget ChatMessageList(){
    
    return StreamBuilder<QuerySnapshot>(
      // stream: chatMessageStream,
      builder: (context,snapshot){
        print(snapshot);
        if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            return MessageTile(snapshot.data!.docs[index]["message"],snapshot.data!.docs[index]["sendBy"] == Constants.myEmail);   // difference from tutorial
          });
        },
      );


  }

  sendMessage(){
    
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
      "message": messageController.text,
      "sendBy": Constants.myEmail,
      "time": DateTime.now().microsecondsSinceEpoch
    };
    databaseMethods.addConversationMessages(widget.chatRoomId,messageMap);
    messageController.text = "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
        
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Screen"),),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Message...",
                        
                          border: InputBorder.none
                        ),
                      )
                      ),
                    // Image.asset("assets/images/Icon-192.png")
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient:LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(48)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.send)),
                    )
                  ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class MessageTile extends StatelessWidget {

  final String message; 
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(left:isSendByMe ? 0: 24,right: isSendByMe? 24: 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight:Alignment.centerLeft ,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              const Color(0xff007EF4),
              const Color(0xff2A75BC)
            ]
              : [
              const Color(0x1A000000),
              const Color(0x1A000000)
              ],
          ),
          borderRadius:  isSendByMe ?
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23),
            ):
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
            )
        ),
        child: Text(message,style: TextStyle(
          fontSize: 17
        ),),
      ),
    );
  }
}