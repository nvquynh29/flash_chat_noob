import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flash/app/models/user_model.dart';

extension UserExtension on firebase_auth.User {
  UserModel toUser() {
    return UserModel(
      id: this.uid,
      name: this.displayName,
      email: this.email,
      password: null,
      photoUrl: this.photoURL,
      status: 'unknown',
      hasStories: false,
    );
  }
}
