import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/constants/collections.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/pages/profile/components/header.dart';
import 'package:flash/app/providers/image_upload_provider.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flash/app/utils/media.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final UserModel _currentUser = Get.find<UserController>().user;
  final _imageUploadProvider = ImageUploadProvider();
  static final routeName = '/profile';
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(userCollection);

  Media media;
  double r;
  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return Scaffold(
      body: Stack(
        children: [
          Header(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(r * 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(r: r),
                  SizedBox(height: r * 60),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: media.width * 0.5 - r * 100),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: usersRef.doc(_currentUser.id).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data.data() != null) {
                          return Avatar(
                            radius: r * 100,
                            imageURL: snapshot.data.data()['photoUrl'],
                          );
                        }
                        return Avatar(
                          radius: r * 100,
                          imageURL: _currentUser.photoUrl,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: r * 40,
                  ),
                  _nameTile(),
                  _emailTile(),
                  _logoutTile(),
                ],
              ),
            ),
          ),
        ],
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

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
    @required this.r,
  }) : super(key: key);

  final double r;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: r * 50,
      height: r * 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.green,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
