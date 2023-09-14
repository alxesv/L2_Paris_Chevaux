import 'package:mongo_dart/mongo_dart.dart';
import 'package:projet_chevaux/database/database.dart';

import '../../models/user.dart';


Future<User> getUserByUsername(String username) async {
  var user = await MongoDatabase.userCollection.findOne(where.eq('username', username));

  return User.fromMap(user);
}

bool doesUserExist(String username) {
  var user = MongoDatabase.userCollection.find({'username': username});

  return user != null;
}