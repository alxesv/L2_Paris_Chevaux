import 'package:flutter/material.dart';

import 'login.dart';
import '../../models/user.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    isloggedin = false;
    Navigator.pushNamed(context, '/start');
  }

  void _userprofile(BuildContext context) {
    Navigator.pushNamed(context, '/userprofile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          FutureBuilder<User?>(
            future: getCurrentUser(loggedusername),  // Assuming getCurrentUser fetches the User object by username
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return IconButton(
                  onPressed: () => _logout(context),
                  icon: Icon(Icons.logout),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return IconButton(
                  onPressed: () => _logout(context),
                  icon: Icon(Icons.logout),
                );
              } else {
                User user = snapshot.data!;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => _userprofile(context),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),  // Fetch avatar URL from the User object
                      ),
                    ),
                    IconButton(
                      onPressed: () => _logout(context),
                      icon: Icon(Icons.logout),
                    ),
                  ],
                );
              }
            },
          ),
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