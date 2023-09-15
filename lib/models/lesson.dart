import 'package:mongo_dart/mongo_dart.dart';

class Lesson {
  final ObjectId id;
  final String name;
  final String terrain;
  final String date;
  final String time;
  final String duration;
  final String subject;
  final bool approved;

  const Lesson({required this.id, required this.name, required this.terrain, required this.date, required this.time, required this.duration, required this.subject, this.approved = false});

  Map<String, dynamic> toMap(){
      return {
        '_id': id,
        'name': name,
        'terrain': terrain,
        'date': date,
        'time': time,
        'duration': duration,
        'subject': subject,
        'approved': approved,
      };
    }

  Lesson.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        terrain = map['terrain'],
        date = map['date'],
        time = map['time'],
        duration = map['duration'],
        subject = map['subject'],
        approved = map['approved'];
}