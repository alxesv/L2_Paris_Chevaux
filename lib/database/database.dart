import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/user.dart';

class MongoDatabase {
  static var db,
      userCollection,
      horseCollection,
      lessonCollection,
      meetingCollection,
      tournamentCollection,
      logsCollection,
      tournamentParticipationCollection;

  static connect() async {
    db = await Db.create(dotenv.env['MONGODB_URI']!);
    await db.open();
    print("connected");
    userCollection = db.collection('users');
    horseCollection = db.collection('horses');
    lessonCollection = db.collection('lessons');
    meetingCollection = db.collection('meetings');
    tournamentCollection = db.collection('tournaments');
    logsCollection = db.collection('logs');
    tournamentParticipationCollection = db.collection('tournamentParticipation');
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

  static Future<List<Map<String, dynamic>>> getLogs() async {
    return await getDocuments(logsCollection);
  }

  static Future<List<Map<String, dynamic>>> getParticipants() async {
    return await getDocuments(tournamentParticipationCollection);
  }
}
