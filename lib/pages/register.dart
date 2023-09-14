import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../models/user.dart';
import '../../models/logs.dart';
import '../../service/users/user_crud.dart';
import '../service/logs/log_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register(BuildContext context) async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      User newUser = User(
        id: ObjectId(),
        username: username,
        email: email,
        password: password,
        avatar: "https://i.pravatar.cc/150?u=$username",
      );

      await saveUser(newUser);
      await newLog(Logs(
          id: ObjectId(),
          time: DateTime.now(),
          type: "user",
          relative: newUser.id));
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => {_register(context)},
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
