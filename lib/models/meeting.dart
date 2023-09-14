import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/user.dart';

class Meeting {
  final ObjectId id;
  final String photo;
  final String name;
  final Enum type;
  final String address;
  final List<Comments> comments;

  const Meeting(this.id, this.photo, this.name, this.type, this.address, this.comments);

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'photo': photo,
        'name': name,
        'type': type,
        'address': address,
        'comments': comments,
      };
    }

  Meeting.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        photo = map['photo'],
        name = map['name'],
        type = map['type'],
        address = map['address'],
        comments = map['comments'];

}

class Comments {
  final ObjectId id;
  final String comment;
  final User author;
  final DateTime datetime;

  const Comments(this.id, this.comment, this.author, this.datetime);

  Map<String, dynamic> toMap(){
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