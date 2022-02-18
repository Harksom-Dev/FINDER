import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:loginsystem/models/user_model.dart';

import 'database_repository.dart';

class MatchData extends Equatable {
  final _databaseRepository = DatabaseRepository();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final COLLECTION = "MatchedData";

  
  int id;
  List<dynamic> matchWith;

  MatchData({
    required this.id,
    required this.matchWith,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        matchWith,
      ];



}

