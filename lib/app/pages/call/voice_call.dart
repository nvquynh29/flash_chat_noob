import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/widgets/circle_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoiceCall extends StatelessWidget {
  static const routeName = '/voiceCall';
  Call call;

  VoiceCall() {
    call = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Expanded(
          child: Column(children: [
            CircleAvatar(
              radius: 60,
            ),
            const SizedBox(height: 30),
            Text(
              call.receiver.name,
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 22),
            ),
            Text(
              call.receiver.email,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            Text('2:53'),
            const SizedBox(height: 20),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleIconButton.border(
            icon: CupertinoIcons.mic_solid,
            onPressed: () => null,
          ),
          const SizedBox(width: 24),
          CircleIconButton.border(
            iconSize: 42,
            icon: CupertinoIcons.video_camera_solid,
            onPressed: () => null,
          ),
          const SizedBox(width: 24),
          CircleIconButton.border(
            icon: CupertinoIcons.volume_up,
            onPressed: () => null,
          ),
        ]),
        const SizedBox(height: 80),
        CircleIconButton(
          icon: CupertinoIcons.phone_down,
          color: Colors.red,
          onPressed: () {
            Get.back();
          },
        ),
        SizedBox(height: 50 + MediaQuery.of(context).padding.bottom),
      ]),
    );
  }
}
