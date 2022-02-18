import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int size;


  const Message(
      {required this.size,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
    size
  ];
  static int messageSize = 0;
  static setSize(size){
    messageSize = size;
  }

  static getSize(){
    return messageSize;
  }
  
}