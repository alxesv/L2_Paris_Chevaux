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

void saveUser(User user) async {
  await MongoDatabase.userCollection.insertMany([user.toMap()]);
}

void deleteUser(String id) async {
  await MongoDatabase.userCollection
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}


// boiler plate code for testing user
        //   saveUser(User(
        //       id: ObjectId(),
        //       username: "username",
        //       password: "password",
        //       email: "email",
        //       avatar: "avatar"));
        // },