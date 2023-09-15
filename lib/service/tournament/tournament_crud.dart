import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';
import '../../models/tournamentParticipation.dart';

import '../../models/tournament.dart';


insertTournament(Tournament tournament) async {
  await MongoDatabase.tournamentCollection.insertAll([tournament.toMap()]);
}

Future<void> deleteTournament(String id) async {
  await MongoDatabase.tournamentCollection
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}

Future<void> joinTournament(ObjectId id, String tournamentId, String difficulty) async {
  await MongoDatabase.tournamentCollection.updateOne(
      where.id(ObjectId.fromHexString(tournamentId)),
      modify.push('participants', id));
  await MongoDatabase.tournamentParticipationCollection.insertAll([TournamentParticipation(id, ObjectId.fromHexString(tournamentId), difficulty).toMap()]);
}
