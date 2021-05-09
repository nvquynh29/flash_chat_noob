import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/dial_screen.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'incoming.dart';

class PickupLayout extends StatefulWidget {
  final Widget scaffold;

  PickupLayout({@required this.scaffold});

  @override
  _PickupLayoutState createState() => _PickupLayoutState();
}

class _PickupLayoutState extends State<PickupLayout> {
  final callRepository = CallRepository();

  @override
  Widget build(BuildContext context) {
    var _currentUser = Get.find<AuthController>().user;
    return (_currentUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callRepository.callStream(uid: _currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                Call call = Call.fromMap(snapshot.data.data());
                if (!call.hasDial) {
                  return Incoming(call: call);
                } else {
                  return DialScreen(call: call);
                }
                // return widget.scaffold;
              }
              return widget.scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
