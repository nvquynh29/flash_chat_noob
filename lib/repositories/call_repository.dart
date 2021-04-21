import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/constants/collections.dart';
import 'package:flash/app/models/call.dart';

class CallRepository {
  final CollectionReference calls =
      FirebaseFirestore.instance.collection(callCollection);

  Stream<DocumentSnapshot> callStream({String uid}) =>
      calls.doc(uid).snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDial = true;
      Map<String, dynamic> hasDialMap = call.toMap();
      call.hasDial = false;
      Map<String, dynamic> hasNoDialMap = call.toMap();

      await calls.doc(call.caller.id).set(hasDialMap);
      await calls.doc(call.receiver.id).set(hasNoDialMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Call call}) async {
    try {
      await calls.doc(call.caller.id).delete();
      await calls.doc(call.receiver.id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
