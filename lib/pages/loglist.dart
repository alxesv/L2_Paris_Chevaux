import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/log_card.dart';

import '../models/logs.dart';

class LogList extends StatefulWidget {
  const LogList({Key? key}) : super(key: key);

  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  List<dynamic> logs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          backgroundColor: Colors.blueAccent,
        ),
        body: FutureBuilder(
            future: MongoDatabase.getLogs(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                logs = snapshot.data.map((e) => Logs.fromMap(e)).toList();

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return LogCard(log: logs[index]);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
