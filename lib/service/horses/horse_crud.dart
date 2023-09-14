import 'package:projet_chevaux/database/database.dart';

import '../../models/horse.dart';


insertHorse(Horse horse) async {
  await MongoDatabase.horseCollection.insertAll([horse.toMap()]);
}