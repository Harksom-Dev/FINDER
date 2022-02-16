import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:loginsystem/models/user_model.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;
  SwipeBloc({
    required DatabaseRepository databaseRepository}) 
    : _databaseRepository = databaseRepository,
    super(SwipeLoading());
  // SwipeBloc():super(SwipeLoading());


  @override
  Stream<SwipeState> mapEventToState(
    SwipeEvent event,
  ) async* {
    
    if (event is LoadUsersEvent) {
      yield* _mapLoadUsersToState(event);
    }
    if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftToState(event, state);
    }
    if (event is SwipeRightEvent) {
      yield* _mapSwipeRightToState(event, state);
    }
  }




  //now we dont care what parameter we get from loaduserevent we always gonna use usersList in class User
  Stream<SwipeState> _mapLoadUsersToState(  
    LoadUsersEvent event,
  ) async* {
    //get a user in firebase and convert to list of User in class User
    _databaseRepository.userInterested();
    // _databaseRepository.userLikedAndDisliked();
    _databaseRepository.cleardislike();
    List<User> userlist = await _databaseRepository.usertoList();
    User.set(userlist);
    _databaseRepository.testdb();
    //getting a user list to calculate suggest algo
    
    // print(User.users);
    // List<User> list = await _databaseRepository.usertoList();
    yield SwipeLoaded(users: User.users);
  }

  Stream<SwipeState> _mapSwipeLeftToState(
    SwipeLeftEvent event,
    SwipeState state,
  ) async* {
    if (state is SwipeLoaded) {
      try {
        addDisLikedUserToList(event.user);
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeRightToState(
    SwipeRightEvent event,
    SwipeState state,
  ) async* {
    if (state is SwipeLoaded) {
      try {
        // perfrom add Liked user to curentUser's like list @ this point
        addLikedUserToList(event.user);
        var cerentUserEmail =
            auth.FirebaseAuth.instance.currentUser?.email;

        // perfrom checkMatch @ this point
        if (cerentUserEmail != null) {
        checkMatchByEmail(
            (cerentUserEmail), event.user.email);
      }
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }

    Future<void> checkMatchByEmail(
      String cerentUserEmail, String userWhoGotLikedEmail) async {
    var tempCurrenUser = _databaseRepository.getUserByEmail(cerentUserEmail);
    var tempUserWhoGotLiked =
        _databaseRepository.getUserByEmail(userWhoGotLikedEmail);
    User? currentUser = await tempCurrenUser;
    User? userWhoGotLiked = await tempUserWhoGotLiked;

    List<List> likeAndDisLikeList = await _databaseRepository
        .getLikedAndUnlikedListByID(userWhoGotLiked!.id);

    // likeAndDisLikeList index 0 is likeList and index 1 is dislikeList
    List likeList = likeAndDisLikeList[0];

    if (likeList.contains(currentUser!.id)) {
      print(currentUser.name + " match with " + userWhoGotLiked.name);
    } else {
      print(currentUser.name + " not match with " + userWhoGotLiked.name);
    }
  }

    Future<void> addLikedUserToList(User user) async {
    User? curentUser = 
        await _databaseRepository.getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email);
    User? userWhoGotLiked = 
        await _databaseRepository.getUserByEmail(user.email);

    List likeList = curentUser!.like;
    if (!likeList.contains(userWhoGotLiked!.id)) {
      likeList.add(userWhoGotLiked.id);
    }

    FirebaseFirestore.instance
        .collection('tempusers')
        .doc('user' + curentUser.id.toString())
        .update({'like': likeList});
  }

  Future<void> addDisLikedUserToList(User user) async {
    User? curentUser = 
        await _databaseRepository.getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email);
    User? userWhoGotDisLiked = 
        await _databaseRepository.getUserByEmail(user.email);

    List disLikeList = curentUser!.dislike;
    if (!disLikeList.contains(userWhoGotDisLiked!.id)) {
      disLikeList.add(userWhoGotDisLiked.id);
    }

    FirebaseFirestore.instance
        .collection('tempusers')
        .doc('user' + curentUser.id.toString())
        .update({'dislike': disLikeList});
  }
}
