import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../models/user.dart';
import '../../models/logs.dart';
import '../../service/users/user_crud.dart';

import '../service/logs/log_service.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  void _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

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
        avatar: avatar.isEmpty ? "https://i.pravatar.cc/150?u=$username" : avatar,
        ffe: 'SET YOUR LINK',
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 3) {
                    return 'Password must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _avatarController,
                decoration: InputDecoration(labelText: 'Avatar URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an avatar URL';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
