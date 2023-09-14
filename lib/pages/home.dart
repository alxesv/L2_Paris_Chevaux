import 'package:flutter/material.dart';
import '../main.dart';
import 'login.dart';

// our home page after we log in to be checked with th isloggedin variable, we need a top bar, with a user icon and a logout button
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    isloggedin = false;
    Navigator.pushNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to the home page",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

