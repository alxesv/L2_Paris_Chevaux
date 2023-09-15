import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../service/users/user_crud.dart';


class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String editedAvatar;
  late int editedAge;
  late String editedPhone;
  late String editedFFE;

  @override
  void initState() {
    super.initState();
    editedAvatar = widget.user.avatar;
    editedAge = widget.user.age;
    editedPhone = widget.user.phone;
    editedFFE = widget.user.ffe;
  }

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    User updatedUser = User(
      avatar: editedAvatar,
      id: widget.user.id,
      email: widget.user.email,
      admin: widget.user.admin,
      password: widget.user.password,
      username: widget.user.username,
      age: editedAge,
      phone: editedPhone,
      ffe: editedFFE,
    );

    await updateUser(updatedUser);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: editedAvatar,
                decoration: InputDecoration(labelText: 'avatar'),
                onSaved: (value) {
                  editedAvatar = value!;
                },
              ),
              TextFormField(
                initialValue: editedAge.toString(),
                decoration: InputDecoration(labelText: 'Age'),
                onSaved: (value) {
                  editedAge = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: editedPhone,
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) {
                  editedPhone = value!;
                },
              ),
              TextFormField(
                initialValue: editedFFE,
                decoration: InputDecoration(labelText: 'FFE'),
                onSaved: (value) {
                  editedFFE = value!;
                },
              ),
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
