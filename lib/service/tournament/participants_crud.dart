import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/tournament.dart';
import '../../models/tournamentParticipation.dart';

insertTournamentParticipation(TournamentParticipation tournamentParticipation) async {
  await MongoDatabase.tournamentParticipationCollection.insertAll([tournamentParticipation.toMap()]);
}