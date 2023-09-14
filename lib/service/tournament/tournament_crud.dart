import 'package:projet_chevaux/database/database.dart';

import '../../models/tournament.dart';


insertTournament(Tournament tournament) async {
  await MongoDatabase.tournamentCollection.insertAll([tournament.toMap()]);
}