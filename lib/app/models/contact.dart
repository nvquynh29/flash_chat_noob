import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/user_model.dart';

class Contact {
  String uid;
  Timestamp addedTime;
  UserModel user;

  Contact({
    this.uid,
    this.addedTime,
    this.user,
  });


  Contact copyWith({
    String uid,
    Timestamp addedTime,
    UserModel user,
  }) {
    return Contact(
      uid: uid ?? this.uid,
      addedTime: addedTime ?? this.addedTime,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'addedTime': addedTime,
      'user': user.toMap(),
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      uid: map['uid'],
      addedTime: map['addedTime'],
      user: UserModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));

  @override
  String toString() => 'Contact(uid: $uid, addedTime: $addedTime, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Contact &&
      other.uid == uid &&
      other.addedTime == addedTime &&
      other.user == user;
  }

  @override
  int get hashCode => uid.hashCode ^ addedTime.hashCode ^ user.hashCode;
}
