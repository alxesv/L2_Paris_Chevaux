import 'package:flutter/material.dart';

import 'login.dart';
import '../../models/user.dart';
import 'start.dart';
import 'userprofile.dart';

import 'package:flutter/material.dart';
// Add other necessary imports here

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void _logout(BuildContext context) {
    isloggedin = false;  // Make sure isloggedin is defined globally or managed properly
    Navigator.pushNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          // ... Your existing AppBar actions
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Navigation'),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.lightBlueAccent],
                  stops: [0.0, 1.0],
                )
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () => _navigateTo(context, '/home'),
            ),
            ListTile(
              title: Text('Lessons'),
              onTap: () => _navigateTo(context, '/LessonFormPage'),
            ),
            ListTile(
              title: Text('Tournament'),
              onTap: () => _navigateTo(context, '/TournamentPage'),
            ),
            ListTile(
              title: Text('User Profile'),
              onTap: () => _navigateTo(context, '/userprofile'),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () => _navigateTo(context, '/login'),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          // ... Add more widgets or code here
        ],
      ),
    );
  }
}
