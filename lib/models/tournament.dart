import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/user.dart';

class Tournament {
  final ObjectId id;
  final String name;
  final String address;
  final String photo;
  final DateTime datetime;
  final List<User> participants;

  const Tournament(this.id, this.name, this.address, this.photo, this.datetime, this.participants);

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'name': name,
        'address': address,
        'photo': photo,
        'datetime': datetime,
        'participants': participants,
      };
    }

  Tournament.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        address = map['address'],
        photo = map['photo'],
        datetime = map['datetime'],
        participants = map['participants'];
}