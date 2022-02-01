import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loginsystem/models/database_repository.dart';
import 'package:loginsystem/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

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

  Stream<SwipeState> _mapLoadUsersToState(  
    LoadUsersEvent event,
  ) async* {
    // _databaseSubscription?.cancel();

    // _databaseRepository.getAllUsers().listen((event) {
    //   print("hello");
    // });
    //_databaseRepository.getAllUsers();
    yield SwipeLoaded(users: event.users);
  }

  Stream<SwipeState> _mapSwipeLeftToState(
    SwipeLeftEvent event,
    SwipeState state,
  ) async* {
    if (state is SwipeLoaded) {
      try {
        // ignore: avoid_print
        print('is this line work?');
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
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }
}
