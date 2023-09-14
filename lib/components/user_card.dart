import 'package:flutter/material.dart';
import 'package:projet_chevaux/models/user.dart';
import 'package:projet_chevaux/service/users/user_crud.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          'Age : ${user.age}',
        ),
        title: Text(user.username),
        subtitle: Text(user.phone),
        // if user is admin
          /*
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                deleteUser(user.id as String);
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