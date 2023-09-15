import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/user.dart';

class Meeting {
  final ObjectId id;
  final String date;
  final String photo;
  final String name;
  final String type;
  final String address;
  final bool approved;

  const Meeting({
      required this.id, required this.photo, required this.name, required this.type, required this.address, required this.date, this.approved = false});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'photo': photo,
      'name': name,
      'type': type,
      'address': address,
      'date': date,
      'approved': approved,
    };
  }

  Meeting.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        photo = map['photo'],
        name = map['name'],
        type = map['type'],
        address = map['address'],
        date = map['date'],
        approved = map['approved'];
}

/*
class Comments {
  final ObjectId id;
  final String comment;
  final User author;
  final DateTime datetime;

  const Comments(this.id, this.comment, this.author, this.datetime);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'comment': comment,
      'author': author,
      'datetime': datetime,
    };
  }

  Comments.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        comment = map['comment'],
        author = map['author'],
        datetime = map['datetime'];
}
*/