import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/lesson_card.dart';
import 'package:projet_chevaux/components/meeting_card.dart';

import '../models/lesson.dart';
import '../models/tournament.dart';
import '../models/meeting.dart';

import '../service/meetings/meetings_service.dart';
import '../service/lessons/lesson_crud.dart';

List<dynamic> filterWeek(List<dynamic> lessons, List<dynamic> filtered) {
  filtered = [];
  var now = DateTime.now();
  lessons.forEach((lesson) {
    var difference = now.difference(DateTime.parse(lesson.date));
    if (difference.inDays.abs() < 7) {
      filtered.add(lesson);
    }
  });
  return filtered;
}

class LessonList extends StatefulWidget {
  const LessonList({Key? key}) : super(key: key);

  @override
  _LessonListState createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  List<dynamic> lessons = [];
  List<dynamic> weekLessons = [];
  bool week = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lessons List'),
          backgroundColor: Colors.redAccent,
        ),
        floatingActionButton: FloatingActionButton(
            child: !week ? Icon(Icons.filter_alt) : Icon(Icons.filter_alt_off),
            onPressed: () {
              setState(() {
                week = !week;
                print(week);
              });
            }),
        body: Column(
          children: [
            FutureBuilder(
              future: MongoDatabase.getLessons(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  lessons =
                      snapshot.data.map((e) => Lesson.fromMap(e)).toList();

                  // filtered by week
                  weekLessons = filterWeek(lessons, weekLessons);

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        !week ? snapshot.data.length : weekLessons.length,
                    itemBuilder: !week
                        ? (context, index) {
                            return LessonCard(
                              lesson: lessons[index],
                              delete: () {
                                deleteLesson(lessons[index].id.toHexString());
                                setState(() {
                                  lessons.removeAt(index);
                                });
                              },
                              approve: () {
                                approveLesson(lessons[index].id.toHexString());
                                setState(() {});
                              },
                            );
                          }
                        : (context, index) {
                            return LessonCard(
                              lesson: weekLessons[index],
                              delete: () {
                                deleteLesson(
                                    weekLessons[index].id.toHexString());
                                setState(() {
                                  weekLessons.removeAt(index);
                                });
                              },
                              approve: () {
                                approveLesson(
                                    weekLessons[index].id.toHexString());
                                setState(() {});
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
          ],
        ));
  }
}
