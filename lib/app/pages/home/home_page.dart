import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/pages/call/pick_up.dart';
import 'package:flash/app/pages/home/components/home_body.dart';
import 'package:flash/app/pages/login/login_page.dart';
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
    return PickupLayout(
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: [
            IconButton(
              onPressed: () {
                Get.find<AuthController>().signOut();
                Get.offAllNamed(LoginPage.routeName);
              },
              icon: Icon(Icons.logout),
            ),
          ],
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
