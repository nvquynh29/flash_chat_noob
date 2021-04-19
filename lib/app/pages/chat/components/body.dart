import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'chat_input_field.dart';

class Body extends StatelessWidget {
  UserModel sender;
  UserModel receiver;
  ScrollController _scrollController = ScrollController();
  Media media;

  Body({@required this.sender, @required this.receiver});

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    return Column(
      children: [
        messageList(),
        ChatInputField(
          sender: sender,
          receiver: receiver,
        ),
      ],
    );
  }

  Widget messageList() {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(sender.id)
            .collection(receiver.id)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // enter messages => auto scroll down
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: (Duration(milliseconds: 250)),
              curve: Curves.easeInOut,
            );
          });

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(4.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                chatMessageItem(snapshot.data.docs[index]),
          );
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.all(1.0),
      child: Container(
        alignment: snapshot['senderId'] == sender.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: snapshot['senderId'] == sender.id
            ? senderLayout(snapshot)
            : receiverLayout(snapshot),
      ),
    );
  }

  Widget senderLayout(DocumentSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      constraints:
          BoxConstraints(maxWidth: media.width * 0.7),
      decoration: snapshot['type'] == 'text'
          ? BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(30),
            )
          : BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: MessageRepository.getMessage(snapshot),
      ),
    );
  }

  Widget receiverLayout(DocumentSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      constraints:
          BoxConstraints(maxWidth: media.width * 0.8),
      decoration: snapshot['type'] == 'text'
          ? BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(30),
            )
          : BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: MessageRepository.getMessage(snapshot),
      ),
    );
  }
}
