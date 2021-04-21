import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/models/user_model.dart';

extension on User {
  UserModel get toUser {
    return UserModel(
        id: uid,
        email: email,
        password: null,
        name: displayName,
        photoUrl: photoURL);
  }
}
