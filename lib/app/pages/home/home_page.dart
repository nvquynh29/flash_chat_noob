import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/pages/call/pick_up.dart';
import 'package:flash/app/pages/home/components/home_body.dart';
import 'package:flash/app/pages/profile/profile.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

// Observer HomeScreen => Icoming layout if call started
class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var _selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;

    return PickupLayout(
      scaffold: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              child: Avatar(
                imageURL: Get.find<UserController>().user.photoUrl,
                radius: r * 22,
              ),
              onTap: () => Get.toNamed(Profile.routeName),
            ),
          ),
          title: Text('Chats'),
        ),
        body: HomeBody(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger), label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
          ],
          currentIndex: _selectedIndex.value,
          onTap: (int index) {
            _selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
