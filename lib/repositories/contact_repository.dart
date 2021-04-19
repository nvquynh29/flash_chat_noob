import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/contact.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class ContactRepository {
  final _firestore = FirebaseFirestore.instance;
  DocumentReference getContactsDocument({String of, String forContact}) =>
      _firestore
          .collection('users')
          .doc(of)
          .collection('contacts')
          .doc(forContact);

  Future<void> addToContacts({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Future<void> addToSenderContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      Contact receiverContact = Contact(
        uid: receiverId,
        addedTime: currentTime,
        user: await UserRepository().getUser(receiverId)
      );

      var receiverMap = receiverContact.toMap();

      await getContactsDocument(of: senderId, forContact: receiverId)
          .set(receiverMap);
    }
  }

  Future<void> addToReceiverContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Contact senderContact = Contact(
        uid: senderId,
        addedTime: currentTime,
        user: await UserRepository().getUser(senderId),
      );

      var senderMap = senderContact.toMap();

      await getContactsDocument(of: receiverId, forContact: senderId)
          .set(senderMap);
    }
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => _firestore
      .collection('users')
      .doc(userId)
      .collection('contacts')
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessage({
    @required String senderId,
    @required String receiverId,
  }) =>
      _firestore
          .collection('messages')
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
