import 'package:flash/app/pages/call/widgets/dial_button.dart';
import 'package:flash/app/pages/call/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF091C40),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Anna williams",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
              Text(
                "Calling…",
                style: TextStyle(color: Colors.white60),
              ),
              SizedBox(height: 5,),
              // Avatar()
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
              SizedBox(height: 10,),
              RoundedButton(
                iconSrc: "assets/icons/call_end.svg",
                press: () {},
                color: Colors.red,
                iconColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}