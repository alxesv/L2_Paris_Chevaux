import 'package:mongo_dart/mongo_dart.dart';

class Horse {
  final ObjectId id;
  final String name;
  final int age;
  final String breed;
  final String color;
  final String sex;
  final String photo;
  final String speciality;

  const Horse(this.id, this.name, this.age, this.breed, this.color, this.sex, this.photo, this.speciality);

  Map<String, dynamic> toMap(){
    return {
      '_id': id,
      'name': name,
      'age': age,
      'breed': breed,
      'color': color,
      'sex': sex,
      'photo': photo,
      'speciality': speciality,
    };
  }

  Horse.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        age = map['age'],
        breed = map['breed'],
        color = map['color'],
        sex = map['sex'],
        photo = map['photo'],
        speciality = map['speciality'];

}