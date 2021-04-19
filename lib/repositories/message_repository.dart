import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/constants/collections.dart';
import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/models/contact.dart';
import 'package:flash/app/models/message.dart';
import 'package:flash/app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import 'contact_repository.dart';

class MessageRepository {
  final FirebaseFirestore _firestore;

  MessageRepository({FirebaseFirestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> sendMessage({Message message}) async {
    var map;
    if (message.type != 'image') {
      map = message.toMap();
    } else {
      map = message.toImageMap();
    }
    ContactRepository().addToContacts(
        senderId: message.senderId, receiverId: message.receiverId);
    await _firestore
        .collection(messageCollection)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    await _firestore
        .collection(messageCollection)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  static Widget getMessage(DocumentSnapshot snapshot) {
    Message message = Message.fromMap(snapshot.data());
    if (message.type != 'image') {
      return Text(
        message.message,
        style: TextStyle(color: black, fontSize: 16),
      );
    } else {
      if (message.photoUrl != null) {
        return CachedImage(
          message.photoUrl,
          width: 250,
          height: 250,
          radius: 10,
        );
      } else {
        return Text('Error photo url');
      }
    }
  }
}
