// packages
import 'package:mongo_dart/mongo_dart.dart';

// config
import '../../database/database.dart';

// models
import '../../models/logs.dart';

Future<void> newLog(Logs log) async {
  print(log.toMap());

  await MongoDatabase.logsCollection.insertAll([log.toMap()]);
}
