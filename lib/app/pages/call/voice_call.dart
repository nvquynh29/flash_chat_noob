import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/widgets/rounded_button.dart';
import 'package:flash/app/utils/call_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoiceCall extends StatelessWidget {
  final Call call;
  final Widget toolbar;

  VoiceCall({@required this.call, @required this.toolbar});

  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        Image.asset(
          "assets/images/full_image.png",
          fit: BoxFit.cover,
        ),
        // Black Layer
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Center(
                  child: Text(
                    CallUtils.getOtherSideName(
                      call: call,
                      myId: Get.find<AuthController>().user.uid,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                  ),
                ),
                // SizedBox(height: 10),
                // Text(
                //   "Incoming 00:01",
                //   style: Theme.of(context).textTheme.headline5.copyWith(
                //         color: Colors.white.withOpacity(0.7),
                //       ),
                // ),
                Spacer(),
                toolbar,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
