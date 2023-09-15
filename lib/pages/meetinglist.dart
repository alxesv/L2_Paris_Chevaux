import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/lesson_card.dart';
import 'package:projet_chevaux/components/meeting_card.dart';
import 'package:projet_chevaux/database/database.dart';

import '../models/lesson.dart';
import '../models/tournament.dart';
import '../models/meeting.dart';

import '../service/meetings/meetings_service.dart';



class MeetingList extends StatefulWidget {
  const MeetingList({Key? key}) : super(key: key);

  @override
  _MeetingListState createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList>{

  List<dynamic> meetings = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meetings List'),
          backgroundColor: Colors.redAccent,
        ),
        body:FutureBuilder(
            future: MongoDatabase.getMeetings(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                meetings = snapshot.data.map((e) => Meeting.fromMap(e)).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return MeetingCard(meeting: meetings[index], delete: () {
                      deleteMeeting(meetings[index].id.toHexString());
                      setState(() {
                        meetings.removeAt(index);
                      });
                    },
                      approve: () {
                        approveMeeting(meetings[index].id.toHexString());
                        setState(() {
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