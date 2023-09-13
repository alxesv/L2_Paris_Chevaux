import 'package:mongo_dart/mongo_dart.dart';

class Lesson {
  final ObjectId id;
  final String name;
  final String terrain;
  final DateTime datetime;
  final String duration;
  final Enum subject;

  const Lesson(this.id, this.name, this.terrain, this.datetime, this.duration, this.subject);

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'name': name,
        'terrain': terrain,
        'datetime': datetime,
        'duration': duration,
        'subject': subject,
      };
    }

  Lesson.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        terrain = map['terrain'],
        datetime = map['datetime'],
        duration = map['duration'],
        subject = map['subject'];

}