import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/lesson.dart';


insertLesson(Lesson lesson) async {
  await MongoDatabase.lessonCollection.insertAll([lesson.toMap()]);
}

Future<void> deleteLesson(String id) async {
  await MongoDatabase.lessonCollection
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}

approveLesson(String id) async {
  await MongoDatabase.lessonCollection.update(
      where.id(ObjectId.fromHexString(id)), modify.set('approved', true));
}