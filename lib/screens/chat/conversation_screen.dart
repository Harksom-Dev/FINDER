import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/models/database.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/realchat';

  static Route route({required String chatroomId, required String userEmail}) {
    return MaterialPageRoute(
      builder: (context) =>
          ConversationScreen(chatroomId, userEmail), // not sure
      settings: RouteSettings(name: routeName),
    );
  }

  final String chatRoomId;
  final String userEmail;
  ConversationScreen(this.chatRoomId, this.userEmail);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream? chatMessageStream;
  ScrollController _scrollController = ScrollController();

  Widget ChatMessageList() {
    return StreamBuilder<dynamic>(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        /*_scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);*/
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length + 1,
            shrinkWrap: true,
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == snapshot.data!.docs.length) {
                return Container(
                  height: 30,
                );
              }
              return MessageTile(
                snapshot.data!.docs[index]["message"],
                snapshot.data!.docs[index]["sendBy"] == Constants.myEmail,
              ); // difference from tutorial
            });
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myEmail,
        "time": DateTime.now().microsecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.userEmail,
                style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(),
            ),
            Container(
              height: 70,
              child: Container(
                // user
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Message...", border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                          sendMessage();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ]),
                                borderRadius: BorderRadius.circular(48)),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.send)),
                      )
                    ],
                  ),
                ),
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
  MessageTile(this.message, this.isSendByMe);
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSendByMe
                  ? [const Color(0xffE6DEDE), const Color(0xFFDCDCDC)]
                  : [const Color(0xFFBEF389), const Color(0xFFA0F24E)],
            ),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Text(
          message,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
