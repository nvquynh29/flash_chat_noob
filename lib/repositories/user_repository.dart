import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserRepository extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final userCollection = 'users';

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(user.id)
          .set(user.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection(userCollection).doc(uid).get();

      return UserModel.fromMap(_doc.data());
    } catch (e) {
      print(e);
      throw Exception('Can not get user by ID');
    }
  }

  List<UserModel> getAllUsers() {
    List<UserModel> _users = [];
    try {
      _firestore.collection(userCollection).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _users.add(UserModel.fromMap(doc.data()));
        });
      });
    } catch (ex) {
      print(ex.toString());
    }
    return _users;
  }
}
