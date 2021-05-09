import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:get/get.dart';

// UserController : control user model
class UserController extends GetxController {
  // var _userModel = FirebaseAuth.instance.currentUser.toUser.obs;
  var _userModel = UserModel().obs;
  @override
  onInit() async {
    var _firebaseUser = FirebaseAuth.instance.currentUser;
    if (_firebaseUser != null) {
      await UserRepository().getUser(_firebaseUser.uid).then((_user) {
        user = _user;
        Get.offAllNamed(HomePage.routeName);
      });
    }
  }

  UserModel get user => _userModel.value;
  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      password: null,
      name: displayName ?? 'Nguyen Van Quynh',
      photoUrl: photoURL,
    );
  }
}
