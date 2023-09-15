import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user.dart';
import 'EditProfilePage.dart';
import 'login.dart';

class UserProfilePage extends StatefulWidget {

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  void _editProfile(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(user: user),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _openLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not launch the link.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (loggedusername.isEmpty) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button to home page
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Text('User Profile'),
      ),
      body: loggedusername.isNotEmpty
          ? FutureBuilder<User?>(
              future: getCurrentUser(loggedusername),
              builder: (context, snapshot) {
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
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'User : ${user.username}',
                            style: const TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Phone : ${user.phone}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Age: ${user.age}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Email : ${user.email}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () => _openLink(user.ffe),
                            child: Text(
                              'Link : ${user.ffe}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
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
          : const Center(
              child: Text("No username found, please log in again."),
            ),
    );
  }
}
