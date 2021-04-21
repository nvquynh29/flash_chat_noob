
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/chat/components/body.dart';
import 'package:flash/app/utils/call_utils.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  static final routeName = '/chat';
  // final callRepository = CallRepository();
  UserModel sender;
  UserModel receiver;

  ChatPage() {
    sender = Get.arguments['sender'];
    receiver = Get.arguments['receiver'];
  }

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  Media media;

  double r;
  CallRepository _callRepository = CallRepository();

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
          onPressed: () async {
            CallUtils.dial(
              from: widget.sender,
              to: widget.receiver,
              clientRole: ClientRole.Audience,
            );
          },
          icon: Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () async {
            CallUtils.dial(
              from: widget.sender,
              to: widget.receiver,
              clientRole: ClientRole.Broadcaster,
            );
          },
          icon: Icon(Icons.videocam),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
