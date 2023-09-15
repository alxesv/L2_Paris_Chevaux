import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/tournament_card.dart';
import 'package:projet_chevaux/components/meeting_card.dart';


import '../models/lesson.dart';
import '../models/tournament.dart';
import '../models/meeting.dart';

import '../service/meetings/meetings_service.dart';
import '../service/tournament/tournament_crud.dart';
import 'login.dart';


class TournamentList extends StatefulWidget {
  const TournamentList({Key? key}) : super(key: key);


  @override
  _TournamentListState createState() => _TournamentListState();
}

late String difficulty;

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
                    }, join :() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Join Tournament'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Select your difficulty level'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Amateur'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  difficulty = "Amateur";
                                  joinTournament(currentId, tournaments[index].id.toHexString(), difficulty);
                                  setState(() {
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Club 1'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  difficulty = "Club 1";
                                  joinTournament(currentId, tournaments[index].id.toHexString(), difficulty);
                                  setState(() {
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Club 2'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  difficulty = "Club 2";
                                  joinTournament(currentId, tournaments[index].id.toHexString(), difficulty);
                                  setState(() {
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Club 3'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  difficulty = "Club 3";
                                  joinTournament(currentId, tournaments[index].id.toHexString(), difficulty);
                                  setState(() {
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Club 4'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  difficulty = "Club 4";
                                  joinTournament(currentId, tournaments[index].id.toHexString(), difficulty);
                                  setState(() {
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );;
                        }
                      );
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