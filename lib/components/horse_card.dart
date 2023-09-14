import 'package:flutter/material.dart';
import 'package:projet_chevaux/models/horse.dart';


class HorseCard extends StatelessWidget {
  const HorseCard({super.key, required this.horse});
  final Horse horse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          'Age : ${horse.age}',
        ),
        title: Text(horse.name),
        subtitle: Text(horse.breed),
        // if user is admin
          /*
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                deleteHorse(horse.id as String);
              },
            ),
          ],
        ),
        */
      ),
    ),
    const SizedBox(height: 10,),
    ],
    );
  }
}
