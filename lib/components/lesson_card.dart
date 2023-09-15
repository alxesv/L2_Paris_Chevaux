import 'package:projet_chevaux/models/lesson.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';


class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.lesson, required this.delete, required this.approve});
  final Lesson lesson;
  final Function delete, approve;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            leading: Text(lesson.date.toString()),
            title: Text(lesson.name),
            subtitle: Text(lesson.subject),
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
                if (lesson.approved == false) ...[
                GestureDetector(
                  child: const Icon(Icons.check_box),
                  onTap: () {
                    approve();
                  },
                ),
                  ]else...[
                    const Icon(Icons.check),
              ]
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