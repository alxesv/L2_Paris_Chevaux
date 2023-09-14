import 'package:flutter/material.dart';
import 'package:projet_chevaux/models/user.dart';
import 'package:projet_chevaux/pages/login.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, required this.delete});
  final User user;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Image.network(user.avatar, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(Icons.error);
        },),
        title: Text(user.username),
        subtitle: Text(user.phone),
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