import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/call/pick_up.dart';
import 'package:flash/app/pages/chat/chat_page.dart';
import 'package:flash/app/pages/search/search_page.dart';
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

    return PickupLayout(
      scaffold: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(),
              ListView.builder(
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
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onTap: () {
            Get.toNamed(SearchPage.routeName);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
