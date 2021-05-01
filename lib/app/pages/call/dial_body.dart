import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flash/app/controllers/channel_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/call_page.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialBody extends StatefulWidget {
  final Call call;

  DialBody({@required this.call});

  @override
  _DialBodyState createState() => _DialBodyState();
}

class _DialBodyState extends State<DialBody> {
  final _callRepository = CallRepository();

  @override
  void dispose() {
    super.dispose();
    this.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Text(
              'Incoming...',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Image Here',
              style: TextStyle(fontSize: 30),
            ),
            // CachedImage(
            //   call.caller.photoUrl,
            //   isRound: true,
            //   radius: 180,
            //   // height: 150,
            //   // width: 150,
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.call.caller.name,
              // call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await _callRepository.endCall(call: widget.call);
                  },
                  icon: Icon(Icons.call_end),
                  color: Colors.red,
                ),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                  onPressed: () async {
                    final channelController = ChannelController();
                    await channelController.onJoin();
                    Get.offAll(
                      CallPage(
                        channelName: widget.call.channelId,
                        role: widget.call.type == 'voice'
                            ? ClientRole.Audience
                            : ClientRole.Broadcaster,
                        call: widget.call,
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => CallPage(
                    //       channelName: widget.call.channelId,
                    //       role: widget.call.type == 'voice'
                    //           ? ClientRole.Audience
                    //           : ClientRole.Broadcaster,
                    //     ),
                    //   ),
                    // );
                    // Get.toNamed(VideoCall.routeName, arguments: call);
                  },
                  icon: Icon(Icons.call),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
