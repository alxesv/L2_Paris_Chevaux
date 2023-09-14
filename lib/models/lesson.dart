import 'package:mongo_dart/mongo_dart.dart';

class Lesson {
  final ObjectId id;
  final String name;
  final String terrain;
  final String date;
  final String time;
  final String duration;
  final String subject;

  const Lesson(this.id, this.name, this.terrain, this.date, this.time, this.duration, this.subject);

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'name': name,
        'terrain': terrain,
        'date': date,
        'time': time,
        'duration': duration,
        'subject': subject,
      };
    }

  Lesson.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        terrain = map['terrain'],
        date = map['date'],
        time = map['time'],
        duration = map['duration'],
        subject = map['subject'];

}