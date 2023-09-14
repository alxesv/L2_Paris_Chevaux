import 'package:flutter/material.dart';
import 'package:projet_chevaux/models/horse.dart';

import '../pages/login.dart';


class HorseCard extends StatelessWidget {
  const HorseCard({super.key, required this.horse, required this.delete});
  final Horse horse;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Image.network(horse.photo, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(Icons.error);
        },),
        title: Text(horse.name),
        subtitle: Text(horse.breed),
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
