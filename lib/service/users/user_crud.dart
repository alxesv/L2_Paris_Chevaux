import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/user.dart';

Future<bool> doesUserExist(String username) async {
  final user = await MongoDatabase.userCollection.findOne(where.eq('username', username));

  return user != null;

}

Future<User> getUserId(String username) async {
  final user = await MongoDatabase.userCollection.findOne(where.eq('username', username));

  if (user != null){
    return User.fromMap(user);
  } else {
    return Future.error('User not found');
  }

}

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


Future<void> saveUser(User user) async {
  await MongoDatabase.userCollection.insertMany([user.toMap()]);
}

 Future<User> readUser(String id) async {
   var req = await MongoDatabase.userCollection.findOne(where.eq("id", id));

   return User(
       id: req.id,
       username: req.username,
       password: req.password,
       email: req.email,
       avatar: req.avatar);
 }
Future<void> deleteUser(String id) async {
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
