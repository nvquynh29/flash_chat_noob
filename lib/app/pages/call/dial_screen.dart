import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/widgets/dial_button.dart';
import 'package:flash/app/pages/call/widgets/rounded_button.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/utils/call_utils.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../loading.dart';

class DialScreen extends StatefulWidget {
  final Call call;
  DialScreen({this.call});

  @override
  _DialScreenState createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {
  Media media;
  double r;

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return Scaffold(
      backgroundColor: Color(0xFF091C40),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: r * 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: media.width * 0.5 - r * 120),
                  child: Avatar(
                    radius: r * 120,
                    imageURL: widget.call.receiver.photoUrl,
                  ),
                ),
                SizedBox(height: r * 30),
                Text(
                  CallUtils.getOtherSideName(
                    call: widget.call,
                    myId: Get.find<AuthController>().user.uid,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                Text(
                  "Calling…",
                  style: TextStyle(color: Colors.white60, fontSize: r * 18),
                ),
                Spacer(),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    DialButton(
                      iconSrc: "assets/icons/Icon Mic.svg",
                      text: "Audio",
                      press: () {},
                    ),
                    DialButton(
                      iconSrc: "assets/icons/Icon Volume.svg",
                      text: "Microphone",
                      press: () {},
                    ),
                    DialButton(
                      iconSrc: "assets/icons/Icon Video.svg",
                      text: "Video",
                      press: () {},
                    ),
                    DialButton(
                      iconSrc: "assets/icons/Icon Message.svg",
                      text: "Message",
                      press: () {},
                    ),
                    DialButton(
                      iconSrc: "assets/icons/Icon User.svg",
                      text: "Add contact",
                      press: () {},
                    ),
                    DialButton(
                      iconSrc: "assets/icons/Icon Voicemail.svg",
                      text: "Voice mail",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  iconSrc: "assets/icons/call_end.svg",
                  press: () async {
                    Get.toNamed(Loading.routeName);
                    await CallRepository()
                        .endCall(call: widget.call)
                        .whenComplete(
                            () => Get.offAllNamed(HomePage.routeName));
                  },
                  color: Colors.red,
                  iconColor: Colors.white,
                ),
                SizedBox(
                  height: r * 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
