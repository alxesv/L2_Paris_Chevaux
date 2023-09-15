import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../service/users/user_crud.dart';
import '../pages/userprofile.dart';
import '../pages/EditProfilePage.dart';

class EditPasswordPage extends StatefulWidget {
  final User user;

  EditPasswordPage({required this.user});

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String editedEmail;
  late String editedUsername;
  late String newPassword;

  @override
  void initState() {
    super.initState();
    editedEmail = widget.user.email;
    editedUsername = widget.user.username;
  }

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    if (editedEmail == widget.user.email && editedUsername == widget.user.username) {
      await updatePassword(widget.user, newPassword);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfilePage(),
        ),
      ).then((_) {
        setState(() {});
      });
    }
    else {
      // Show some error message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Email and username incorrect.'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: editedEmail,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  editedEmail = value!;
                },
              ),
              TextFormField(
                initialValue: editedUsername,
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) {
                  editedUsername = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onSaved: (value) {
                  newPassword = value!;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
