import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/pages/home/components/home_body.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/pages/search/search_page.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flash/app/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static final routeName = '/home';
  var _selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
        ],
        currentIndex: _selectedIndex.value,
        onTap: (int index) {
          _selectedIndex.value = index;
        },
      ),
    );
  }

  // Widget buildBody() {
  //   return SafeArea(
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: grey.withOpacity(0.4),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: TextField(
  //               onTap: () {
  //                 Get.toNamed(SearchPage.routeName);
  //               },
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: 'Search',
  //                 prefixIcon: Icon(Icons.search),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: 10,
  //             itemBuilder: (context, index) {
  //               return UserCard(
  //                 avatar: Avatar(
  //                   radius: 75 / 2,
  //                   hasStories: false,
  //                   online: true,
  //                   imageURL:
  //                       'https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
  //                 ),
  //                 title: 'Michanel',
  //                 subtitle: 'How are you brother? See you again.',
  //                 onTap: () => print('User chat Tapped!'),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
