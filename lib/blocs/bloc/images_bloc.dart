import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loginsystem/models/database_repository.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;
  ImagesBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ImagesLoading());

  @override
  Stream<ImagesState> _mapEventToState(
    ImagesEvent event)
    async* {
    if (event is LoadImages) {
      yield* _mapLoadImagesToState();
    }
    if (event is UpdateImages) {
      yield* _mapUpdateImagesToState(event);
    }
  }

  Stream<ImagesState> _mapLoadImagesToState() async* {
    _databaseSubscription?.cancel();
    print('ehllo');
    await DatabaseRepository()
        .getUserByEmail(auth.FirebaseAuth.instance.currentUser?.email)
        .then((userData) => add(UpdateImages(userData!.imageUrls)));
    print('State load image');
    
  }

  Stream<ImagesState> _mapUpdateImagesToState(UpdateImages event) async* {
    print('hello');
    yield ImagesLoaded(imageUrls: event.imageUrls);
    print('State Loaded Image');
  }
}
