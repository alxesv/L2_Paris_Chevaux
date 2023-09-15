import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/user.dart';

class Tournament {
  final ObjectId id;
  final String name;
  final String address;
  final String photo;
  final String date;
  final String time;
  final List<ObjectId> participants;

  const Tournament(this.id, this.name, this.address, this.photo, this.date, this.time, this.participants);

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'name': name,
        'address': address,
        'photo': photo,
        'date': date,
        'time': time,
        'participants': participants,
      };
    }

  Tournament.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        address = map['address'],
        photo = map['photo'],
        date = map['date'],
        time = map['time'],
        participants = map['participants'];
}