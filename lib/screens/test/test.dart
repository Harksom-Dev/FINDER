
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/user_model.dart';

class StreamBuilderTest extends StatefulWidget {
  const StreamBuilderTest({Key? key}) : super(key: key);

  @override
  _StreamBuilderTestState createState() => _StreamBuilderTestState();
}

class _StreamBuilderTestState extends State<StreamBuilderTest> {
  DatabaseRepository _databaseRepository = new DatabaseRepository();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream? buiderStream;
  List<User> userlist=[];

    @override
  void initState() {
    
    
    getUserInfo();
    _databaseRepository.getAllUsers();
    super.initState();
  }
  Future<List<User>> Streamtest() async {
    QuerySnapshot qshot = 
      await FirebaseFirestore.instance.collection('users').get();

    return qshot.docs.map(
        (doc) => User(
            id: doc['id'],
            name: doc['name'],
            age: doc['age'],
            imageUrls: doc['imageUrls'],
            bio: doc['bio'],
            interested: doc['interested']
            )
      ).toList();

  }
  getUserInfo() async {
    List<User> users = await Streamtest();
    print('hiiii');
    print(users);
    userlist.addAll(users);
    // print(userlist);
    
    _databaseRepository.testdb().then((value){
      setState(() {
        buiderStream = value;
      });
    });
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 101'),
      ),
      body: Container(
        child: StreamBuilder<dynamic>(
          stream: buiderStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              //print("helopooooooo");

              snapshot.data.docs.forEach((doc) {
                //print(doc["email"]);
              });
            } 
            
            if (snapshot.hasData) {
              return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) =>
                  Text(snapshot.data!.docs[index]['interested'][0]),
            );
            }else{
              print("oh ooooooo");
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}