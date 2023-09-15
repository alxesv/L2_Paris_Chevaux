import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/tournament_card.dart';
import 'package:projet_chevaux/components/meeting_card.dart';


import '../models/lesson.dart';
import '../models/tournament.dart';
import '../models/meeting.dart';

import '../service/meetings/meetings_service.dart';
import '../service/tournament/tournament_crud.dart';


class TournamentList extends StatefulWidget {
  const TournamentList({Key? key}) : super(key: key);

  @override
  _TournamentListState createState() => _TournamentListState();
}

class _TournamentListState extends State<TournamentList>{

  List<dynamic> tournaments = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tournaments List'),
          backgroundColor: Colors.redAccent,
        ),
        body:
          FutureBuilder(
            future: MongoDatabase.getTournaments(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                tournaments = snapshot.data.map((e) => Tournament.fromMap(e)).toList();

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TournamentCard(tournament: tournaments[index], delete: () {
                      deleteTournament(tournaments[index].id.toHexString());
                      setState(() {
                        tournaments.removeAt(index);
                      });
                    },
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
    );
  }
}