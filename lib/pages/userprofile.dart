import 'package:flutter/material.dart';
import '../../models/user.dart';

import 'login.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  void _editProfile(User user) {
    print('Edit button clicked for ${user.username}');
  }

  @override
  void initState() {
    super.initState();
    if (loggedusername.isEmpty) {
      // Navigate the user back to login or show a message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: loggedusername.isNotEmpty // Ensure the username is not empty
          ? FutureBuilder<User?>(
              future: getCurrentUser(loggedusername),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No user found');
                } else {

                  User user = snapshot.data!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 100.0,
                            backgroundImage: NetworkImage(user.avatar),  // Fetch avatar URL from the User object
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Name: ${user.username}',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Age: ${user.age}',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Phone: ${user.phone}',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),

                          ElevatedButton(
                            onPressed: () => _editProfile(user),
                            child: Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            )
          : Center(
              child: Text("No username found, please login again."),
            ),
    );
  }
}
