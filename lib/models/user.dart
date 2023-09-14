import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String username;
  final String password;
  final String email;
  final bool admin;
  final String avatar;
  final String phone;
  final int age;

  const User(this.id, this.username, this.password, this.email, this.admin, this.avatar, this.phone, this.age);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'email': email,
      'admin': admin,
      'avatar': avatar,
      'phone': phone,
      'age': age,
    };
  }

    User.fromMap(Map<String, dynamic> map)
        : id = map['_id'],
          username = map['username'],
          password = map['password'],
          email = map['email'],
          admin = map['admin'],
          avatar = map['avatar'],
          phone = map['phone'],
          age = map['age'];
  }