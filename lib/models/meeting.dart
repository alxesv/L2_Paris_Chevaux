import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/user.dart';

class Meeting {
  final ObjectId id;
  final String date;
  final String photo;
  final String name;
  final String type;
  final String address;
  final List<ObjectId> comments;

  const Meeting(
      this.id, this.photo, this.name, this.type, this.address, this.date,
      [this.comments = const <ObjectId>[]]);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'photo': photo,
      'name': name,
      'type': type,
      'address': address,
      'comments': comments,
      'date': date,
    };
  }

  Meeting.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        photo = map['photo'],
        name = map['name'],
        type = map['type'],
        address = map['address'],
        comments = map['comments'],
        date = map['date'];
}

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
      : id = map['id'],
        comment = map['comment'],
        author = map['author'],
        datetime = map['datetime'];
}
