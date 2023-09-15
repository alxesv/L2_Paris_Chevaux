import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../database/database.dart';
import '../service/meetings/meetings_service.dart';
import '../models/meeting.dart';
import '../../models/logs.dart';
import '../service/logs/log_service.dart';

late String date;
String subject = "Dressage";
String type = "Apéro";

class MeetingFormPage extends StatelessWidget {
  MeetingFormPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  _insert() async {
    var meeting = Meeting(
        id: M.ObjectId(), photo: _photoController.text,
        name: _nameController.text, type: type, address:_addressController.text, date:date);
        await newLog(Logs(
        id: M.ObjectId(),
        time: DateTime.now(),
        type: "meeting",
        relative: meeting.id,
        message:
            'New meeting ${meeting.name} has been planned for ${meeting.date}.'));
    saveMeeting(meeting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new meeting'),
        backgroundColor: Colors.amberAccent,
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
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: _photoController,
                        decoration:
                            const InputDecoration(hintText: "Image URL"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(hintText: "Address"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    const RadioSelectType(),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    const dateField(),
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
                      _insert();
                      //Navigator.pop(context, 'Add');
                    }
                    _formKey.currentState?.reset();
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

enum Type { meal, aperitif }

class RadioSelectType extends StatefulWidget {
  const RadioSelectType({super.key});

  @override
  _RadioSelectTypeState createState() => _RadioSelectTypeState();
}

class _RadioSelectTypeState extends State<RadioSelectType> {
  Type? _type = Type.meal;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Thème: '),
          ],
        ),
        ListTile(
          title: const Text('Repas'),
          leading: Radio<Type>(
            value: Type.meal,
            groupValue: _type,
            onChanged: (Type? value) {
              setState(() {
                _type = value;
                type = "meal";
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Apéro'),
          leading: Radio<Type>(
            value: Type.aperitif,
            groupValue: _type,
            onChanged: (Type? value) {
              setState(() {
                _type = value;
                type = "aperitif";
              });
            },
          ),
        ),
      ],
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
            icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              _dateController.text = formattedDate;
              date = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
        });
  }
}
