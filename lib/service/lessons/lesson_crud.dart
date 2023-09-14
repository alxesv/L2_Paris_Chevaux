import 'package:projet_chevaux/database/database.dart';

import '../../models/lesson.dart';


insertLesson(Lesson lesson) async {
  await MongoDatabase.lessonCollection.insertAll([lesson.toMap()]);
}