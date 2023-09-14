import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../service/horses/horse_crud.dart';
import '../models/horse.dart';

String sex = "male";
String speciality = "sprint";

class HorseFormPage extends StatelessWidget {
  HorseFormPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();


  _insert() async {
    var horse = Horse(
        M.ObjectId(),
        _nameController.text,
        int.parse(_ageController.text),
        _breedController.text,
        _colorController.text,
        sex,
        _photoController.text,
        speciality

    );
    await insertHorse(horse);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new horse'),
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
                    TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _ageController,
                        decoration: const InputDecoration(hintText: "Age"),
                        keyboardType: TextInputType.number,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _breedController,
                        decoration: const InputDecoration(hintText: "Breed"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _colorController,
                        decoration: const InputDecoration(hintText: "Color"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    const RadioSelectSex(),
                    TextFormField(
                        controller: _photoController,
                        decoration: const InputDecoration(hintText: "Photo url"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    const RadioSelectSpeciality()
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
enum SexType { male, female }

class RadioSelectSex extends StatefulWidget{
  const RadioSelectSex({super.key});

  @override
  _RadioSelectSexState createState() => _RadioSelectSexState();
}

class _RadioSelectSexState extends State<RadioSelectSex> {
  SexType? _type = SexType.male;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Sex: '),
          ],
        ),
        ListTile(
          title: const Text('Male'),
          leading: Radio<SexType>(
            value: SexType.male,
            groupValue: _type,
            onChanged: (SexType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio<SexType>(
            value: SexType.female,
            groupValue: _type,
            onChanged: (SexType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

enum SpecialityType { dressage, jumping, flatwork, allround }

class RadioSelectSpeciality extends StatefulWidget{
  const RadioSelectSpeciality({super.key});

  @override
  _RadioSelectSpecialityState createState() => _RadioSelectSpecialityState();
}

class _RadioSelectSpecialityState extends State<RadioSelectSpeciality> {
  SpecialityType? _type = SpecialityType.dressage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        const Row(
          children: <Widget>[
            Text('Speciality: '),
          ],
        ),
        ListTile(
          title: const Text('Dressage'),
          leading: Radio<SpecialityType>(
            value: SpecialityType.dressage,
            groupValue: _type,
            onChanged: (SpecialityType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Jumping'),
          leading: Radio<SpecialityType>(
            value: SpecialityType.jumping,
            groupValue: _type,
            onChanged: (SpecialityType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Flatwork'),
          leading: Radio<SpecialityType>(
            value: SpecialityType.flatwork,
            groupValue: _type,
            onChanged: (SpecialityType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Allround'),
          leading: Radio<SpecialityType>(
            value: SpecialityType.allround,
            groupValue: _type,
            onChanged: (SpecialityType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
      ],
    );
  }
}