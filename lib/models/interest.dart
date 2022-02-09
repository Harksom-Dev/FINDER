import 'package:equatable/equatable.dart';

class Interest extends Equatable {
  final int
      cat; //this is seperate 3 categ of interest 1. programing language 2. sports 3.Musics
  final int id; //this is unique id of item in list
  final String name; // name of thing you are interesting in

  const Interest({
    required this.cat,
    required this.id,
    required this.name,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [cat, id, name];
}
