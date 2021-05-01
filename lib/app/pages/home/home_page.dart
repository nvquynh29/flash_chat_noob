import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/pages/call/pick_up.dart';
import 'package:flash/app/pages/home/components/recent_chat.dart';
import 'package:flash/app/pages/people/people_page.dart';
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
  var _selectedIndex = 0;

  List<Widget> _pages = [RecentChat(), PeoplePage()];

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
          leading: _selectedIndex == 0 ? Padding(
          padding: const EdgeInsets.all(6.0),
            child: InkWell(
              child: Avatar(
                imageURL: Get.find<UserController>().user.photoUrl,
                radius: r * 22,
              ),
              onTap: () => Get.toNamed(Profile.routeName),
            ),
          ) : Container(),
          title: _selectedIndex == 0 ? Text('Chats') : Text('People'),
          centerTitle: true,
        ),
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger), label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
