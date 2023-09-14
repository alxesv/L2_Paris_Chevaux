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