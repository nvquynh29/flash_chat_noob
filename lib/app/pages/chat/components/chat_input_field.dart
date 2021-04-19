import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/message.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatInputField extends StatelessWidget {
  final _messageController = TextEditingController();

  UserModel sender;
  UserModel receiver;

  ChatInputField({@required this.sender, @required this.receiver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Aa',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    var text = _messageController.text.trim();
    if (text.isNotEmpty) {
      Message _message = Message(
        message: text,
        receiverId: receiver.id,
        senderId: sender.id,
        timestamp: Timestamp.now(),
        type: 'text',
      );
      MessageRepository().sendMessage(
        message: _message,
      );
      _messageController.clear();
    }
  }
}
