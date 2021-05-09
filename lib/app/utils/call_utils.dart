import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/controllers/channel_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/call/call_page.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallUtils {
  static final _callRepository = CallRepository();

  static dial({UserModel from, UserModel to, ClientRole clientRole}) async {
    Call call = Call(
      caller: from,
      receiver: to,
      startTime: Timestamp.now(),
      endTime: Timestamp.now(),
      duration: 0,
      type: clientRole == ClientRole.Broadcaster ? 'video' : 'voice',
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await _callRepository.makeCall(call: call);

    if (callMade) {
      await ChannelController(
              role: ClientRole.Broadcaster, channelName: call.channelId)
          .onJoin();
      Get.to(CallPage(
        channelName: call.channelId,
        role: clientRole,
        call: call,
      ));
    }
  }

  static String getOtherSideName({Call call, String myId}) {
    if (call.caller == null || call.receiver == null) {
      return 'Name String';
    }
    if (call.caller.id == myId) {
      return call.receiver.name;
    } else {
      return call.caller.name;
    }
  }

  static bool hasDial({Call call, String uid}) {
    return call.caller.id == uid;
  }
}
