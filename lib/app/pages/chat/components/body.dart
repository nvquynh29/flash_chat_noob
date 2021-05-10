import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/models/message.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/providers/image_upload_provider.dart';
import 'package:flash/app/utils/enum.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class ChatBody extends StatefulWidget {
  UserModel sender;
  UserModel receiver;

  ChatBody({@required this.sender, @required this.receiver});

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  ScrollController _scrollController = ScrollController();

  final _messageController = TextEditingController();

  final _imageUploadProvider = ImageUploadProvider();

  Media media;

  double r;

  bool _showEmojiPicker = false;

  FocusNode messageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return Column(
      children: [
        messageList(),
        _imageUploadProvider.getViewState == ViewState.LOADING
            ? Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 15),
                child: CircularProgressIndicator(),
              )
            : Container(),
        _chatInputField(),
        _showEmojiPicker ? Container(child: emojiContainer()) : Container(),
      ],
    );
  }

  Widget emojiContainer() {
    return EmojiPicker(
      bgColor: grey,
      indicatorColor: Colors.blue,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        _messageController.text += emoji.emoji;
      },
    );
  }

  Widget messageList() {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(widget.sender.id)
            .collection(widget.receiver.id)
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        alignment: snapshot['senderId'] == widget.sender.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: snapshot['senderId'] == widget.sender.id
            ? senderLayout(snapshot)
            : receiverLayout(snapshot),
      ),
    );
  }

  Widget senderLayout(DocumentSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      constraints: BoxConstraints(maxWidth: media.width * 0.65),
      decoration: snapshot['type'] == 'text'
          ? BoxDecoration(
              color: primary.withOpacity(0.7),
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
      constraints: BoxConstraints(maxWidth: media.width * 0.7),
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

  Widget _chatInputField() {
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
              color: primary,
              iconSize: r * 27,
            ),
            IconButton(
              onPressed: () => pickImage(source: ImageSource.gallery),
              icon: Icon(Icons.image),
              color: primary,
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
                      color: primary,
                      iconSize: r * 27,
                    ),
                    SizedBox(
                      width: 3 * r,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () => hideEmojiContainer(),
                        style: TextStyle(
                          fontSize: 16,
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
                      color: primary,
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
    imageRepo.uploadImageMessage(
      image: selectedImage,
      receiverId: widget.receiver.id,
      senderId: widget.sender.id,
    );
  }
}
