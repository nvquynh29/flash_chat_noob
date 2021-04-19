import 'package:flash/app/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

class Storage {
  static final storage = GetStorage();
  static void saveUser(UserModel user) {
    storage.write('currentUser', user.toJson());
  }

  static UserModel getUser() {
    try {
      String userJson = storage.read('currentUser');
      return UserModel.fromJson(userJson);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static void remove({@required String key}) {
    storage.remove(key);
  }

  static bool isLoggedIn() {
    return storage.read('currentUser') != null;
  }

  static void clearUser() {
    remove(key: 'currentUser');
  }

  static Future<void> reset() async {
    await storage.erase();
  }
}
