import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _userController = Get.find<UserController>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // To use function: bindStream
  // User: FirebaseUser
  Rxn<User> _user = Rxn<User>();

  User get user => _user.value;

  @override
  onInit() async {
    // Binds an existing [Stream] to this Rx to keep the values in sync
    // [Stream] : _auth.authStateChanges()
    _user.bindStream(_auth.authStateChanges());
  }

  Future createUser({String email, String password, String name}) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      final user = UserModel(
        id: _authResult.user.uid,
        email: email,
        password: password,
        name: name,
        status: 'unknown',
        hasStories: false,
      );
      if (await UserRepository().createNewUser(user)) {
        _userController.user = user;
        // Get.offAll(Home)
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    //TODO: indicatior loading
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      _userController.user =
          await UserRepository().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      _userController.clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
