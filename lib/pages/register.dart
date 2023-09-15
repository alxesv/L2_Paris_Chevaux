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
  final TextEditingController _avatarController =
      TextEditingController(); // New Controller for Avatar

  void _register(BuildContext context) async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final avatar = _avatarController.text;

    try {
      User newUser = User(
        id: ObjectId(),
        username: username,
        email: email,
        password: password,
        avatar: avatar.isEmpty
            ? "https://i.pravatar.cc/150?u=$username"
            : avatar, // Use input link if not empty
      );

      await saveUser(newUser);
      await newLog(Logs(
          id: ObjectId(),
          time: DateTime.now(),
          type: "user",
          relative: newUser.id,
          message: '${newUser.username} has joined.'));
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
            TextField(
              // New TextField for Avatar
              controller: _avatarController,
              decoration: InputDecoration(labelText: 'Avatar URL'),
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
