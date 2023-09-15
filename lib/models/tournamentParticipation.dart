import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/tournament.dart';


class TournamentParticipation {
  final ObjectId userId;
  final ObjectId tournamentId;
  final String difficulty;

  const TournamentParticipation(this.userId, this.tournamentId, this.difficulty);

  Map<String, dynamic> toMap(){
    return {
      'userId': userId,
      'tournamentId': tournamentId,
      'difficulty': difficulty,
    };
  }

  TournamentParticipation.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        tournamentId = map['tournamentId'],
        difficulty = map['difficulty'];

}