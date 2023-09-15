import 'package:projet_chevaux/models/meeting.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';


class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.meeting, required this.delete, required this.approve});
  final Meeting meeting;
  final Function delete, approve;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            leading: Image.network(meeting.photo, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Icon(Icons.error);
            },),
            title: Text(meeting.name),
            subtitle: Text('${meeting.address} on ${meeting.date}'),
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
                if (meeting.approved == false) ...[
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