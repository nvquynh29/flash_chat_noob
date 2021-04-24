import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/message.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/providers/image_upload_provider.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  UserModel sender;
  UserModel receiver;

  ChatInputField({@required this.sender, @required this.receiver});

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _messageController = TextEditingController();
  bool _showEmojiPicker = false;
  FocusNode messageFocus = FocusNode();
  ImageUploadProvider _imageUploadProvider;

  Media media;
  double r;
  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10 * r,
        vertical: 5 * r,
      ),
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () => pickImage(source: ImageSource.camera),
              icon: Icon(Icons.camera_alt),
              color: Colors.blue,
              iconSize: r * 27,
            ),
            IconButton(
              onPressed: () => pickImage(source: ImageSource.gallery),
              icon: Icon(Icons.image),
              color: Colors.blue,
              iconSize: r * 27,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3 * r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        if (!_showEmojiPicker) {
                          // Keyboard is visible now
                          hideKeyBoard();
                          showEmojiContainer();
                        } else {
                          // Keyboard is not visible now
                          showKeyBoard();
                          hideEmojiContainer();
                        }
                      },
                      icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                      color: Colors.black,
                      iconSize: r * 27,
                    ),
                    SizedBox(
                      width: 3 * r,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () => hideEmojiContainer(),
                        style: TextStyle(
                          fontSize: r * 15,
                        ),
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
                      color: Colors.blueAccent,
                      iconSize: r * 27,
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

  void showKeyBoard() => messageFocus.requestFocus();
  void hideKeyBoard() => messageFocus.unfocus();
  void showEmojiContainer() {
    setState(() {
      _showEmojiPicker = true;
    });
  }

  void hideEmojiContainer() {
    setState(() {
      _showEmojiPicker = false;
    });
  }

  void _sendMessage() {
    var text = _messageController.text.trim();
    if (text.isNotEmpty) {
      Message _message = Message(
        message: text,
        receiverId: widget.receiver.id,
        senderId: widget.sender.id,
        timestamp: Timestamp.now(),
        type: 'text',
      );
      MessageRepository().sendMessage(
        message: _message,
      );
      _messageController.clear();
    }
  }

  void pickImage({@required ImageSource source}) async {
    final imageRepo = ImageUploadProvider();
    final selectedImage = await imageRepo.pickImage(source: source);
    imageRepo.uploadImage(
      image: selectedImage,
      receiverId: widget.receiver.id,
      senderId: widget.sender.id,
    );
  }

  // void _showModalBottomSheet() {
  //   Get.bottomSheet(
  //     Container(
  //       width: media.width,
  //       height: media.height * 0.3,
  //       child: Column(
  //         children: [
  //           ListTile(
  //             leading: Icon(Icons.camera_enhance),
  //             title: Text('Capture'),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.image),
  //             title: Text('Galary'),
  //           ),
  //         ],
  //       ),
  //     )
  //   );
  // }
}
