import '../../database/database.dart';
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
  final String ffe;

  const User(
      {required this.id,
      required this.username,
      required this.password,
      required this.email,
      required this.avatar, this.ffe = "set your link",
      this.admin = false,
      this.age = 0,
      this.phone = '',
      });



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
      'ffe': ffe,
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
        age = map['age'],
        ffe = map['ffe'];

}


Future<User?> getCurrentUser(String username) async {
  print("Searching for user: $username");
  try {
    var query = await MongoDatabase.userCollection.findOne({"username": username});
    print("Query result: $query");

    if (query != null) {
      User currentUser = User(
        id: query['_id'],
        username: query['username'],
        email: query['email'],
        password: query['password'],
        age: query['age'],
        phone: query['phone'],
        avatar: query['avatar'],
        ffe: query['ffe'],
      );
      print("User found: ${currentUser.username}");
      return currentUser;
    } else {
      print("User not found in database.");
      return null;
    }
  } catch (e) {
    print("Error fetching user: $e");
    return null;
  }
}

