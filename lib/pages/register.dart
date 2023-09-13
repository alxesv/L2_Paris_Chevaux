import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String passwordConfirmation = '';
  String avatar = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Username Field
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'avatar',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'enter link of your avatar';
                }
                return null;
              },
              onSaved: (String? value) {
                avatar = value ?? '';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (String? value) {
                username = value ?? '';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (String? value) {
                email = value ?? '';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (String? value) {
                password = value ?? '';
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password confirmation',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password again';
                }
                return null;
              },
              onSaved: (String? value) {
                passwordConfirmation = value ?? '';
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  
                  Navigator.pushNamed(context, '/login');
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
