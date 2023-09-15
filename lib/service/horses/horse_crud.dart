import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/horse.dart';


insertHorse(Horse horse) async {
  await MongoDatabase.horseCollection.insertAll([horse.toMap()]);
}

Future<void> deleteHorse(String id) async {
  await MongoDatabase.horseCollection;
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}