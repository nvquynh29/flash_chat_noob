
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/video_call.dart';
import 'package:flash/app/widgets/cached_image.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialBody extends StatelessWidget {
  final Call call;
  final _callRepository = CallRepository();

  DialBody({@required this.call});
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
            Text('Image Here', style: TextStyle(fontSize: 30),),
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
              'Caller name',
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
                    await _callRepository.endCall(call: call);
                  },
                  icon: Icon(Icons.call_end),
                  color: Colors.red,
                ),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(VideoCall.routeName, arguments: call);
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
