import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/chat/chat_page.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flash/app/widgets/user_card.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeoplePage extends StatelessWidget {
  List<UserModel> _userList = UserRepository().getAllUsers();

  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;

    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          final _user = _userList[index];
          return UserCard(
            avatar: Avatar(
              imageURL: _user.photoUrl,
              radius: r * 30,
              online: true,
              hasStories: _user.hasStories,
            ),
            title: _user.name,
            subtitle: Container(),
            trailing: Container(),
            onTap: () {
              Map<String, dynamic> arguments = {
                'sender': Get.find<UserController>().user,
                'receiver': _user,
              };
              Get.toNamed(ChatPage.routeName, arguments: arguments);
            },
          );
        },
      ),
    );
  }
}
