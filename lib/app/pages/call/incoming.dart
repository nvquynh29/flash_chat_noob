import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flash/app/controllers/channel_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/call_page.dart';
import 'package:flash/app/pages/call/voice_call.dart';
import 'package:flash/app/pages/call/widgets/rounded_button.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Incoming extends StatefulWidget {
  final Call call;

  Incoming({@required this.call});

  @override
  _IncomingState createState() => _IncomingState();
}

class _IncomingState extends State<Incoming> {
  final _callRepository = CallRepository();

  @override
  void dispose() {
    super.dispose();
    this.deactivate();
  }

  @override
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
                    widget.call.caller.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Incoming...",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                  ),
                ),
                Spacer(),
                // ToolBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () async {
                        await _callRepository.endCall(call: widget.call);
                      },
                      color: Colors.red,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () async {
                        final channelController = ChannelController();
                        await channelController.onJoin();
                        // TODO: Route => VoiceCall
                        Get.offAll(
                          CallPage(
                            channelName: widget.call.channelId,
                            role: widget.call.type == 'voice'
                                ? ClientRole.Audience
                                : ClientRole.Broadcaster,
                            call: widget.call,
                          ),
                        );
                      },
                      color: Colors.green,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
