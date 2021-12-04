import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {


  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Widget ChatMessageList(){

    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Screen"),),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //controller: searchTextEditingController,
                        decoration: InputDecoration(
                          hintText: "Message...",
                        
                          border: InputBorder.none
                        ),
                      )
                      ),
                    // Image.asset("assets/images/Icon-192.png")
                    GestureDetector(
                      onTap: (){
                        //initiateSearch();
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