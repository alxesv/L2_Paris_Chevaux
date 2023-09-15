import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../service/lessons/lesson_crud.dart';
import '../models/lesson.dart';
import '../../models/logs.dart';
import '../service/logs/log_service.dart';

String terrain = "Outdoor";
late String date;
late String time;
String duration = "30 min";
String subject = "Dressage";

class LessonFormPage extends StatelessWidget {
  LessonFormPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  _insert() async {
    var lesson = Lesson(M.ObjectId(), _nameController.text, terrain, date, time,
        duration, subject);

    await insertLesson(lesson);
    await newLog(Logs(
        id: M.ObjectId(),
        time: DateTime.now(),
        type: "lesson",
        relative: lesson.id,
        message:
            'New lesson ${lesson.name} has been added for ${lesson.date} at ${lesson.time}.'));

    await insertLesson(lesson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new lesson'),
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
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    const RadioSelectTerrain(),
                    const SizedBox(height: 8),
                    const dateField(),
                    const SizedBox(height: 8),
                    const timefield(),
                    const SizedBox(height: 8),
                    const RadioSelectDuration(),
                    const SizedBox(height: 8),
                    const RadioSelectSubject()
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
                      Navigator.pop(context, 'Add');
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

enum TerrainType { outdoor, indoor }

class RadioSelectTerrain extends StatefulWidget {
  const RadioSelectTerrain({super.key});

  @override
  _RadioSelectTerrainState createState() => _RadioSelectTerrainState();
}

class _RadioSelectTerrainState extends State<RadioSelectTerrain> {
  TerrainType? _type = TerrainType.outdoor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Terrain: '),
          ],
        ),
        ListTile(
          title: const Text('Outdoor'),
          leading: Radio<TerrainType>(
            value: TerrainType.outdoor,
            groupValue: _type,
            onChanged: (TerrainType? value) {
              setState(() {
                _type = value;
                terrain = "Outdoor";
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Indoor'),
          leading: Radio<TerrainType>(
            value: TerrainType.indoor,
            groupValue: _type,
            onChanged: (TerrainType? value) {
              setState(() {
                _type = value;
                terrain = "Indoor";
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

enum DurationType { half, full }

class RadioSelectDuration extends StatefulWidget {
  const RadioSelectDuration({super.key});

  @override
  _RadioSelectDurationState createState() => _RadioSelectDurationState();
}

class _RadioSelectDurationState extends State<RadioSelectDuration> {
  DurationType? _type = DurationType.half;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Duration: '),
          ],
        ),
        ListTile(
          title: const Text('30 min'),
          leading: Radio<DurationType>(
            value: DurationType.half,
            groupValue: _type,
            onChanged: (DurationType? value) {
              setState(() {
                _type = value;
                duration = "30 min";
              });
            },
          ),
        ),
        ListTile(
          title: const Text('1 hour'),
          leading: Radio<DurationType>(
            value: DurationType.full,
            groupValue: _type,
            onChanged: (DurationType? value) {
              setState(() {
                _type = value;
                duration = "1 hour";
              });
            },
          ),
        ),
      ],
    );
  }
}

enum SubjectType { dressage, jumping, flatwork }

class RadioSelectSubject extends StatefulWidget {
  const RadioSelectSubject({super.key});

  @override
  _RadioSelectSubjectState createState() => _RadioSelectSubjectState();
}

class _RadioSelectSubjectState extends State<RadioSelectSubject> {
  SubjectType? _type = SubjectType.dressage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Subject: '),
          ],
        ),
        ListTile(
          title: const Text('Dressage'),
          leading: Radio<SubjectType>(
            value: SubjectType.dressage,
            groupValue: _type,
            onChanged: (SubjectType? value) {
              setState(() {
                _type = value;
                subject = "Dressage";
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Jumping'),
          leading: Radio<SubjectType>(
            value: SubjectType.jumping,
            groupValue: _type,
            onChanged: (SubjectType? value) {
              setState(() {
                _type = value;
                subject = "Jumping";
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Flatwork'),
          leading: Radio<SubjectType>(
            value: SubjectType.flatwork,
            groupValue: _type,
            onChanged: (SubjectType? value) {
              setState(() {
                _type = value;
                subject = "Flatwork";
              });
            },
          ),
        ),
      ],
    );
  }
}

class timefield extends StatefulWidget {
  const timefield({super.key});

  @override
  _timefieldState createState() => _timefieldState();
}

class _timefieldState extends State<timefield> {
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _timeController,
        decoration: const InputDecoration(
            icon: Icon(Icons.access_time), labelText: "Enter Time"),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());

          if (pickedTime != null) {
            String formattedTime = pickedTime.format(context);

            setState(() {
              _timeController.text = formattedTime;
              time = formattedTime;
            });
          } else {
            print("Time is not selected");
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
        });
  }
}
