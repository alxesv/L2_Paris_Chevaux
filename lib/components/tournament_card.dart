import 'package:projet_chevaux/models/tournament.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';


class TournamentCard extends StatelessWidget {
  const TournamentCard({super.key, required this.tournament, required this.delete, required this.join});
  final Tournament tournament;
  final Function delete, join;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            leading: Image.network(tournament.photo, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Icon(Icons.error);
            },),
            title: Text(tournament.name),
            subtitle: Text('${tournament.address} on ${tournament.date}'),
            // if user is admin
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ if(isadmin)...[
                GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    delete();
                  },
                ),
              ], if (!tournament.participants.contains(currentId)) ...[
                GestureDetector(
                  child: const Icon(Icons.add),
                  onTap: () {
                    join();
                  },
                ),
              ]else ...[
                const Icon(Icons.check),
              ]
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }

}