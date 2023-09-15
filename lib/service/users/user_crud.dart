import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/user.dart';

Future<bool> doesUserExist(String username) async {
  final user = await MongoDatabase.userCollection
      .findOne(where.eq('username', username));

  return user != null;
}

Future<bool> isAdmin(String username) async {
  final user = await MongoDatabase.userCollection
      .findOne(where.eq('username', username));
  print(user['admin']);
  return user['admin'] == true;
}

Future<User> getUserId(String username) async {
  final user = await MongoDatabase.userCollection
      .findOne(where.eq('username', username));

  if (user != null) {
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

updateUser(User updatedUser) async {
  var query = await MongoDatabase.userCollection
      .findOne(where.id(updatedUser.id));
  print(query);
  query['username'] = updatedUser.username;
  query['phone'] = updatedUser.phone;
  query['age'] = updatedUser.age;
  query['ffe'] = updatedUser.ffe;
  print("1");
  await MongoDatabase.userCollection.update(
      where.id(updatedUser.id), modify.set(
    'avatar', updatedUser.avatar,).set(
    'phone', updatedUser.phone,).set(
    'age', updatedUser.age,).set(
    'ffe', updatedUser.ffe,),);
  print("2");

}

Future<void> addFfe(String username, String ffe) async {
  await MongoDatabase.userCollection.update(
      where.eq("username", username), modify.set("ffe", ffe),
      upsert: true);
  print("added ffe");
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
    avatar: req.avatar,
    ffe: req.ffe,
  );
}

Future<void> deleteUser(String id) async {
  await MongoDatabase.userCollection
      .deleteOne(where.id(ObjectId.fromHexString(id)));
}
