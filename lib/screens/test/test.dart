
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginsystem/models/database.dart';
import 'package:loginsystem/models/database_repository.dart';

class StreamBuilderTest extends StatefulWidget {
  const StreamBuilderTest({Key? key}) : super(key: key);

  @override
  _StreamBuilderTestState createState() => _StreamBuilderTestState();
}

class _StreamBuilderTestState extends State<StreamBuilderTest> {
  DatabaseRepository _databaseRepository = new DatabaseRepository();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream? buiderStream;


    @override
  void initState() {
    // TODO: implement initState
    
    getUserInfo();
    
    super.initState();
  }

  getUserInfo() async {
    
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
            print('hello $snapshot ');
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) =>
                  Text(snapshot.data!.docs[index]),
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