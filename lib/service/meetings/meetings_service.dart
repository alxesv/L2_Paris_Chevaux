// packages
import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/models/meeting.dart';

// config
import '../../database/database.dart';

// model
import '../../models/user.dart';

Future<void> saveMeeting(Meeting meeting) async {
  await MongoDatabase.meetingCollection.insertMany([meeting.toMap()]);
}

Future<Meeting> getMeeting(String id) async {
  var query = await MongoDatabase.meetingCollection
      .findOne(where.id(ObjectId.fromHexString(id)));

  var meeting = Meeting(query.id, query.photo, query.name, query.type,
      query.address, query.comments);
  return meeting;
}

Future<void> editMeeting(Meeting meeting) async {
  var query =
      await MongoDatabase.meetingCollection.findOne(where.id(meeting.id));

  query["photo"] = meeting.photo;
  query["name"] = meeting.photo;
  query["type"] = meeting.photo;
  query["address"] = meeting.photo;

  await MongoDatabase.meetingCollection.save(query);
}

Future<void> deleteMeeting(String id) async {
  await MongoDatabase.meetingCollection
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}
