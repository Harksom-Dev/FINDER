import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/helper/constants.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/message_model.dart';
import 'package:loginsystem/screens/review/review_screen.dart';
import 'package:loginsystem/models/database_repository.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/realchat';
  //final arg = ModalRoute.of(context)!.settings.arguments as Arg;
  static Route route({required String chatroomId, required String userEmail}) {
    return MaterialPageRoute(
      builder: (_) => ConversationScreen(chatroomId, userEmail), // not sure
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
  int messageNum = 0;
  var messageSize = 0;
  bool isFetch = true;
  bool isFirst = true;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream? chatMessageStream;
  ScrollController _scrollController = ScrollController();
  ScrollController listScrollController = ScrollController();

  //testing a db func to get all user
  DatabaseRepository _databaseRepository = new DatabaseRepository();

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
  }

  

  Widget ChatMessageList() {
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      print('hiiiiiiiiiiiiiiiiiiiiii');
      if(_scrollController.offset == 0 && (messageNum < messageSize )){
        print('heloooooooooo');
        
      //   isFetch = true;
      //   messageNum += 10;
      //   databaseMethods.allMessageSize(widget.chatRoomId);
      //   messageSize = Message.getSize();
      //   databaseMethods.getConversationMessages(widget.chatRoomId,messageNum).then((value) {
      // setState(() {
      //   chatMessageStream = value;
      // });
      //   });
      }
    });
    final subscription = chatMessageStream?.listen(
      (data) => {
        // print('is First = $isFirst'),
        // if(isFirst){
        //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut),
        //   isFirst = false
        // },
        if(!isFetch){
          _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut),
        }else{
          isFetch = false
        },
        print('is last fist =  $isFirst')
        // print('loadddddd????????????????????????'),
        
      },
    );
    return StreamBuilder<dynamic>(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length + 1,
          //reverse: true,
          shrinkWrap: true,
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index == snapshot.data!.docs.length) {
              return Container(
                height: 80,
              );
            }
            return MessageTile(
              snapshot.data!.docs[index]["message"],
              snapshot.data!.docs[index]["sendBy"] == Constants.myEmail,
            );
            // difference from tutorial
          },
        );

        //scrollToBottom();
        /* return ListView.builder(
          itemCount: snapshot.data!.docs.length + 1,
          //reverse: true,
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
            );
            // difference from tutorial
          },
        ); */
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
    _scrollController = ScrollController();
    // TODO: implement initState
    print('hello');
    messageNum = 10;
    databaseMethods.allMessageSize(widget.chatRoomId);
    messageSize = Message.getSize();
    databaseMethods.getConversationMessages(widget.chatRoomId,messageNum).then((value) {
      setState(() {
        chatMessageStream = value;
      });
      isFirst = true;
    });
    _scrollController.addListener(() {
      // print(_scrollController.offset);
      if(_scrollController.offset == 0 && (messageNum < messageSize )){
        // print('loadnew messgae');
        // print(messageNum);
        isFetch = true;
        messageNum += 10;
        databaseMethods.allMessageSize(widget.chatRoomId);
        messageSize = Message.getSize();
        databaseMethods.getConversationMessages(widget.chatRoomId,messageNum).then((value) {
      setState(() {
        chatMessageStream = value;
      });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.userEmail.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black54)),
                InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, "/review");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewScreen(widget.userEmail)),
                    );
                    print("Match user Profile Review !");
                  },
                  // here wher is the profile of user is
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.redAccent,
                    ),
                    child: Text(
                      widget.userEmail.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF2D8E1), Color(0xFF92B2FD)])),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(),
            ),
            Container(
              height: 80,
              child: Container(
                // user
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Color(0xFFF594B7)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: "Message...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                              // _scrollController.
                              sendMessage();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      const Color(0x36FFFFFF),
                                      const Color(0x0FFFFFFF)
                                    ]),
                                    borderRadius: BorderRadius.circular(48)),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.send_rounded,
                                  color: Color(0xFFF594B7),
                                )),
                          ),
                        )
                      ],
                    ),
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
    final maxWidth = MediaQuery.of(context).size.width / 4;
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? maxWidth : 10, right: isSendByMe ? 10 : maxWidth),
      margin: EdgeInsets.fromLTRB(10, 15, 5, 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSendByMe
                  ? [const Color(0xffE6DEDE), const Color(0xFFDCDCDC)]
                  : [const Color(0xFFBEF389), const Color(0xFFA0F24E)],
            ),
            borderRadius: isSendByMe
                ? BorderRadius.circular(23)
                : BorderRadius.circular(23),
            border: Border.all(color: Colors.black.withAlpha(150))),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
