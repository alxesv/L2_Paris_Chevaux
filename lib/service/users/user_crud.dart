// packages
import 'package:mongo_dart/mongo_dart.dart';

// config
import '../../database/database.dart';

// models
import '../../models/user.dart';

// --------------------------- actual code

// init db collection

Future<bool> login(String username, String password) async {
  var query =
      await MongoDatabase.userCollection.findOne({"username": username});

  print(query);

  if (query['password'] == password) {
    print("logged in!");
    return true;
  } else {
    print("wrong credentials!");
    return false;
  }
}
/*
void saveUser(User user) async {
  await MongoDatabase.userCollection.insertMany([user.toMap()]);
}

void saveUser(User user) async {
  await MongoDatabase.userCollection.insertOne(user.toMap());
}
*/


Future<void> saveUser(User user) async {
  await MongoDatabase.userCollection.insertMany([user.toMap()]);
}


// Future<User> readUser(String id) async {
//   var req = await MongoDatabase.userCollection.findOne(where.eq("id", id));

//   return User(
//       id: req.id,
//       username: req.username,
//       password: req.password,
//       email: req.email,
//       role: req.role,
//       avatar: req.avatar);
// }
