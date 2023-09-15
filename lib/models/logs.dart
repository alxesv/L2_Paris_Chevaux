import 'package:mongo_dart/mongo_dart.dart';

// TYPES OF LOGS :
// "user"
// "meeting"
// "lesson"
// "tournament"

class Logs {
  final ObjectId id;
  final DateTime time;
  final String type;
  final ObjectId relative;
  final String message;

  const Logs({
    required this.id,
    required this.time,
    required this.type,
    required this.relative,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'time': time,
      'type': type,
      'relative': relative,
      'message': message,
    };
  }

  Logs.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        time = map['time'],
        type = map['type'],
        relative = map['relative'],
        message = map['message'];
}
