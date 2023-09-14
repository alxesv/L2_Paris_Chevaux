import 'package:flutter/material.dart';
import '../main.dart';
import '../database/database.dart';
import '../service/users/user_crud.dart';

bool isloggedin = false;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String username = '';
    String password = '';

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  username = value ?? '';
                },
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  password = value ?? '';
                },
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () async {  // Note that I've made this asynchronous
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();

                    // Call your login function and pass the username and password
                    bool isAuthenticated = await login(username, password);

                    if (isAuthenticated) {
                      Navigator.pushNamed(context, '/home');
                      print('username: $username' + " Connected");
                      isloggedin = true;
                      print(isloggedin);
                    } else {
                      print("Authentication failed!");
                      // Here you could show a dialog or a SnackBar to inform the user
                      // that authentication failed
                    }
                  }
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                  child: const Text(
                    'BACK',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/start');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
