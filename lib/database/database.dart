import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db,
      userCollection,
      horseCollection,
      lessonCollection,
      meetingCollection,
      tournamentCollection;

  static connect() async {
    db = await Db.create(dotenv.env['MONGODB_URI']!);
    await db.open();
    print("connected");
    userCollection = db.collection('users');
    horseCollection = db.collection('horse');
    lessonCollection = db.collection('lesson');
    meetingCollection = db.collection('meeting');
    tournamentCollection = db.collection('tournament');
  }

  static Future<List<Map<String, dynamic>>> getDocuments(connection) async {
    try {
      var documents = await connection.find().toList();
      return documents;
    } catch (e) {
      print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    return await getDocuments(userCollection);
  }

  static Future<List<Map<String, dynamic>>> getHorses() async {
    return await getDocuments(horseCollection);
  }

  static Future<List<Map<String, dynamic>>> getLessons() async {
    return await getDocuments(lessonCollection);
  }

  static Future<List<Map<String, dynamic>>> getMeetings() async {
    return await getDocuments(meetingCollection);
  }

  static Future<List<Map<String, dynamic>>> getTournaments() async {
    return await getDocuments(tournamentCollection);
  }
}
