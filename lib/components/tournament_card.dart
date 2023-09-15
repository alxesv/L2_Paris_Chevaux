import 'package:projet_chevaux/models/tournament.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';


class TournamentCard extends StatelessWidget {
  const TournamentCard({super.key, required this.tournament, required this.delete, required this.approve});
  final Tournament tournament;
  final Function delete, approve;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            leading: Text(tournament.date.toString()),
            title: Text(tournament.name),
            subtitle: Text(tournament.address),
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
                GestureDetector(
                  child: const Icon(Icons.approval),
                  onTap: () {
                    approve();
                  },
                ),
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