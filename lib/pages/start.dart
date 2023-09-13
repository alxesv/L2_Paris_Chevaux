import 'package:flutter/material.dart';
import '../main.dart';
// This will be our start page, with the login button, that will redirect to the login.dart file, and register button that will redirect to register.dart file
class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                new BoxConstraints(
                  minHeight: 90.0,
                  maxHeight: 100.0,
                  minWidth: 300.0,
                  maxWidth: 300.0,
                ),
                child: ElevatedButton(
                  child:
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },

                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                new BoxConstraints(
                  minHeight: 90.0,
                  maxHeight: 100.0,
                  minWidth: 300.0,
                  maxWidth: 300.0,
                ),
                child: ElevatedButton(
                  child:
                  const Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, '/register');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
