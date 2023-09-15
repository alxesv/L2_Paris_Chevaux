import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../service/tournament/tournament_crud.dart';
import '../models/tournament.dart';
import '../models/user.dart';
import '../service/users/user_crud.dart';
import '../pages/login.dart';

late String date;
late String time;
List<M.ObjectId> participants = [];

class TournamentPage extends StatelessWidget {
  TournamentPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();


  _insert() {
    var tournament = Tournament(
        M.ObjectId(),
        _nameController.text,
        _addressController.text,
        _photoController.text,
        date,
        time,
        participants
    );
    insertTournament(tournament);
    _formKey.currentState?.reset();
    participants = [];
  }


  @override
  Widget build(BuildContext context) {
    _participantsController.text = '$loggedusername,';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new tournament'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: "Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(hintText: "Address"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _photoController,
                        decoration: const InputDecoration(hintText: "Photo url"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    const dateField(),
                    const SizedBox(height: 8),
                    const timefield(),
                    const SizedBox(height: 8),
            TextFormField(
              controller: _participantsController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Enter Participants usernames separated by a comma"
              ),
              onSaved:
                  (value) async {
                if (value != null && value.isNotEmpty) {
                  List<String> usernames = value.split(',');
                  for (int i = 0; i < usernames.length; i++) {
                    try {
                      bool exists = await doesUserExist(usernames[i]);
                      if (exists) {
                        User user = await getUserId(usernames[i]);
                        participants.add(user.id);
                        if (i == usernames.length - 1) {
                          _insert();
                          print("Tournament added");
                        }
                      }
                    }catch(e){
                      print(e);
                    }
                  }
                }
              }
              ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      Navigator.pop(context, 'Add');
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}


class dateField extends StatefulWidget {
  const dateField({super.key});

  @override
  _dateFieldState createState() => _dateFieldState();
}

class _dateFieldState extends State<dateField> {

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _dateController,
        decoration: const InputDecoration(

            icon: Icon(Icons.calendar_today),
            labelText: "Enter Date"
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101)
          );

          if(pickedDate != null ){
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

            setState(() {
              _dateController.text = formattedDate;
              date = formattedDate;
            });
          }else{
            print("Date is not selected");
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
        }
    );

  }

}

class timefield extends StatefulWidget {
  const timefield({super.key});

  @override
  _timefieldState createState() => _timefieldState();
}

class _timefieldState extends State<timefield>{
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _timeController,
        decoration: const InputDecoration(
            icon: Icon(Icons.access_time),
            labelText: "Enter Time"
        ),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now()
          );

          if(pickedTime != null ){
            String formattedTime = pickedTime.format(context);

            setState(() {
              _timeController.text = formattedTime;
              time = formattedTime;
            });
          }else{
            print("Time is not selected");
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
        }
    );
  }
}