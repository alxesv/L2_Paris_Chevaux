import 'package:flutter/material.dart';
import 'package:projet_chevaux/database/database.dart';
import 'package:projet_chevaux/components/user_card.dart';

import '../models/user.dart';
import '../service/users/user_crud.dart';


class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>{

  List<dynamic> users = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: MongoDatabase.getUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
              users = snapshot.data.map((e) => User.fromMap(e)).toList();

        return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return UserCard(user: users[index], delete: () {
                  deleteUser(users[index].id.toHexString());
                  setState(() {
                    users.removeAt(index);
                  });
                });
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