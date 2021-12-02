import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginsystem/model/database.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  //create search text controler to hander about text frlom user
  TextEditingController searchTextEditingController = new TextEditingController();

  //maybe change to jsonquery or something
  QuerySnapshot searchSnapshot;




  initiateSearch(){
    databaseMethods.getUserByEmail(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }



  // create chatroom, send user to conversation screen,pushreplacement
  createChatroomAndStartConversation(String userEmail){             //so long function name ;-;
    // List<String> users = [userEmail]
    // databaseMethods.createChatRoom(, )
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return SearchTile(
          userEmail: searchSnapshot.docs[index].get("email"),  // func get may change
        );
      }): Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: "search username...",
                      
                        border: InputBorder.none
                      ),
                    )
                    ),
                  // Image.asset("assets/images/Icon-192.png")
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
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
                      child: Icon(Icons.search)),
                  )
                ],),
            ),
            searchList()
        ],),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {

  final String userEmail;
  SearchTile({this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userEmail,style: TextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child:Text("Messages") ,
            ),
          )
        ],
        ),
    );
  }
}