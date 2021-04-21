import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:flash/app/models/user_model.dart';

class Call {
  String type;
  @required
  UserModel caller;
  @required
  UserModel receiver;
  String channelId;
  Timestamp startTime;
  Timestamp endTime;
  int duration;
  bool hasDial;

  Call({
    this.caller,
    this.receiver,
    this.channelId,
    this.startTime,
    this.endTime,
    this.duration,
    this.hasDial = true,
    this.type,
  });


  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'caller': caller.toMap(),
      'receiver': receiver.toMap(),
      'channelId': channelId,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
      'hasDial': hasDial,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      type: map['type'],
      caller: UserModel.fromMap(map['caller']),
      receiver: UserModel.fromMap(map['receiver']),
      channelId: map['channelId'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      duration: map['duration'],
      hasDial: map['hasDial'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Call(caller: $caller, receiver: $receiver, channelId: $channelId, startTime: $startTime, endTime: $endTime, duration: $duration, hasDial: $hasDial, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Call &&
      other.caller == caller &&
      other.receiver == receiver &&
      other.channelId == channelId &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.duration == duration &&
      other.hasDial == hasDial &&
      other.type == type;
  }

  @override
  int get hashCode {
    return caller.hashCode ^
      receiver.hashCode ^
      channelId.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      duration.hashCode ^
      hasDial.hashCode ^
      type.hashCode;
  }
}
