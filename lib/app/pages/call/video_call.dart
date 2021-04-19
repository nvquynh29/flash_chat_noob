import 'package:flash/app/pages/call/widgets/circle_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCall extends StatelessWidget {
  static final routeName = '/videoCall';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(height: 20,),
        Expanded(
          child: Column(children: [
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 100,
                  height: 153,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                )),
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
        ]),
        CircleIconButton(
          icon: CupertinoIcons.phone_down,
          color: Colors.red,
          onPressed: () {
            Get.back();
          },
        ),
        const SizedBox(height: 20),
        SizedBox(height: 50 + MediaQuery.of(context).padding.bottom),
      ]),
    );
  }
}
