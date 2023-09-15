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
              title: Text('Add a lesson'),
              onTap: () => _navigateTo(context, '/LessonFormPage'),
            ),
            ListTile(
              title: Text('Add a tournament'),
              onTap: () => _navigateTo(context, '/TournamentPage'),
            ),
            ListTile(
              title: Text('Add a meeting'),
              onTap: () => _navigateTo(context, '/MeetingFormPage'),
            ),
            ListTile(
              title: Text('Add a horse'),
              onTap: () => _navigateTo(context, '/horse_form'),
            ),
            ListTile(
              title: Text('Activity'),
              onTap: () => _navigateTo(context, '/LogList'),
            ),
            ListTile(
              title: Text('Meeting list'),
              onTap: () => _navigateTo(context, '/MeetingList'),
            ),
            ListTile(
              title: Text('Lesson list'),
              onTap: () => _navigateTo(context, '/LessonList'),
            ),
            ListTile(
              title: Text('Tournament list'),
              onTap: () => _navigateTo(context, '/TournamentList'),
            ),
            ListTile(
              title: Text('Users list'),
              onTap: () => _navigateTo(context, '/UsersList'),
            ),
            ListTile(
              title: Text('Horser list'),
              onTap: () => _navigateTo(context, '/horseslist'),
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
      body: Center(
        child:
          Wrap(
            direction: Axis.vertical,
            children: [
              const Text(
                "Welcome to the home page",
                style: TextStyle(fontSize: 30),
              ),
              Image.network("https://cdn.pixabay.com/photo/2017/10/31/07/49/horses-2904536_640.jpg")
            ],
          ),
          // ... Add more widgets or code here
      ),
    );
  }
}
