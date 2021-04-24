import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flash/app/utils/media.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final UserModel _currentUser = Get.find<UserController>().user;
  static final routeName = '/profile';
  Media media;
  double r;
  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: r * 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: media.width * 0.5 - r * 50),
                child: Avatar(
                  radius: r * 50,
                  imageURL: _currentUser.photoUrl,
                ),
              ),
              SizedBox(
                height: r * 20,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Change Avatar')),
              SizedBox(
                height: r * 30,
              ),
              _nameTile(),
              _emailTile(),
              _logoutTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTile() {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(
        _currentUser.name,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _emailTile() {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text(
        _currentUser.email,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _logoutTile() {
    return ListTile(
      onTap: () {
        Get.find<AuthController>().signOut();
        Get.offAllNamed(LoginPage.routeName);
      },
      leading: Icon(Icons.logout),
      title: Text(
        'Logout',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
