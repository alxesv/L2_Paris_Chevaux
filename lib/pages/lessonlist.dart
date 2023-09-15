import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/lesson_card.dart';
import 'package:projet_chevaux/components/meeting_card.dart';


import '../models/lesson.dart';
import '../models/tournament.dart';
import '../models/meeting.dart';

import '../service/meetings/meetings_service.dart';
import '../service/lessons/lesson_crud.dart';


class LessonList extends StatefulWidget {
  const LessonList({Key? key}) : super(key: key);

  @override
  _LessonListState createState() => _LessonListState();
}

class _LessonListState extends State<LessonList>{

  List<dynamic> lessons = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons List'),
        backgroundColor: Colors.redAccent,
      ),
      body:Column (children: [
        FutureBuilder(
          future: MongoDatabase.getLessons(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              lessons = snapshot.data.map((e) => Lesson.fromMap(e)).toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return LessonCard(lesson: lessons[index], delete: () {
                    deleteLesson(lessons[index].id.toHexString());
                    setState(() {
                      lessons.removeAt(index);
                    });
                  },
                  approve: () {
                    approveLesson(lessons[index].id.toHexString());
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
      ],)
    );
  }
}