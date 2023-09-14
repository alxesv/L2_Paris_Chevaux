import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/horse_card.dart';

import '../models/horse.dart';


class HorsesList extends StatefulWidget {
  const HorsesList({Key? key}) : super(key: key);

  @override
  _HorsesListState createState() => _HorsesListState();
}

class _HorsesListState extends State<HorsesList>{

  List<dynamic> horses = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horses List'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: MongoDatabase.getHorses(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            horses = snapshot.data.map((e) => Horse.fromMap(e)).toList();

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return HorseCard(horse: horses[index]);
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