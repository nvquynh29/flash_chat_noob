import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/chat/chat_page.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flash/app/widgets/user_card.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  static final routeName = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<UserModel> _userList = UserRepository().getAllUsers();
  List<UserModel> _result = [];
  bool _emptyInput = true;

  Future<void> onSearchChanged(String value) async {
    if (value != null && value.isNotEmpty) {
      setState(() {
        _emptyInput = false;
      });
      _result = _userList.where((user) {
        return user.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
    } else {
      _result?.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ListView.builder(
        itemCount: _result?.length,
        itemBuilder: (context, index) {
          UserModel _receiver = _result[index];
          return UserCard(
            avatar: Avatar(
              radius: 75 / 2,
              hasStories: false,
              online: true,
              imageURL:
                  'https://images.unsplash.com/photo-157174114q0674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
            ),
            title: _receiver.name ?? Container(),
            subtitle: Container(),
            isBoldText: true,
            trailing: Container(),
            onTap: () {
              Map<String, dynamic> arguments = {
                'sender': Get.find<UserController>().user,
                'receiver': _receiver
              };
              Get.toNamed(ChatPage.routeName, arguments: arguments);
            },
          );
        },
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TextField(
        autofocus: true,
        controller: _searchController,
        onChanged: onSearchChanged,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
      actions: [
        _emptyInput
            ? Container()
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _emptyInput = true;
                  });
                  _searchController.clear();
                  _result?.clear();
                },
              ),
      ],
    );
  }
}
