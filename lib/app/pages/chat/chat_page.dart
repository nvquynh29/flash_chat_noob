import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/call/video_call.dart';
import 'package:flash/app/pages/call/voice_call.dart';
import 'package:flash/app/pages/chat/components/body.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  static final routeName = '/chat';
  UserModel sender;
  UserModel receiver;


  ChatPage() {
    sender = Get.arguments['sender'];
    receiver = Get.arguments['receiver'];
  }

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {
  Media media;

  double r;


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(sender: widget.sender, receiver: widget.receiver),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          // Avatar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: media.width * 0.4,
                child: Text(
                  widget.receiver.name,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Active 3m ago',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Map<String, dynamic> arguments = {
              'caller': widget.sender,
              'receiver': widget.receiver
            };
            Get.toNamed(VoiceCall.routeName, arguments: arguments);
          },
          icon: Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(VideoCall.routeName);
          },
          icon: Icon(Icons.videocam),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
