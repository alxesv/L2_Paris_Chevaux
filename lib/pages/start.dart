import 'package:flutter/material.dart';
import '../main.dart';
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
          SizedBox(height: 10),
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
                    Navigator.pushNamed(context, '/register');
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
