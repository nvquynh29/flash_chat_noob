import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/contact.dart';
import 'package:flash/app/pages/chat/chat_page.dart';
import 'package:flash/app/pages/search/search_page.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flash/app/widgets/user_card.dart';
import 'package:flash/repositories/contact_repository.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash/app/utils/media.dart';

import 'last_message_container.dart';

class HomeBody extends StatelessWidget {
  final _contactRepo = ContactRepository();
  Media media;
  double ratio;
  @override
  Widget build(BuildContext context) {
    media = Media(context);
    ratio = media.ratio;
    return Column(children: [
      Padding(
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
      ),
      StreamBuilder<QuerySnapshot>(
        stream: _contactRepo.fetchContacts(
            userId: Get.find<AuthController>().user.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var contactDocs = snapshot.data.docs;
            if (contactDocs.isEmpty) {
              return Column(children: [
                SizedBox(
                  height: media.height * 0.35,
                ),
                Center(
                  child: Text(
                    'Let\'s chat with your friends',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: black.withOpacity(0.5),
                    ),
                  ),
                ),
              ]);
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: contactDocs.length,
                itemBuilder: (context, index) {
                  final currentUser = Get.find<UserController>().user;
                  // AuthMethods().updateUserStatus(
                  //   uid: currentUser.id,
                  //   status: UserStatus.online,
                  // );
                  Contact contact = Contact.fromMap(contactDocs[index].data());
                  return UserCard(
                    avatar: Avatar(
                      radius: ratio * 25,
                      imageURL:
                          'https://images.unsplash.com/photo-1571741140674-8949ca7df2a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
                      online: true,
                    ),
                    title: contact.user.name,
                    subtitle: LastMessageContainer(
                      stream: _contactRepo.fetchLastMessage(
                          senderId: currentUser.id, receiverId: contact.uid),
                    ),
                    onTap: () {
                      Map<String, dynamic> arguments = {
                        'sender': currentUser,
                        'receiver': contact.user
                      };
                      Get.toNamed(ChatPage.routeName, arguments: arguments);
                    },
                  );
                  // return Container(
                  //   child: ListTile(
                  //     title: Text(
                  //       contact.uid,
                  //       style: TextStyle(fontSize: 20),
                  //     ),
                  // subtitle: LastMessageContainer(
                  //   stream: _contactRepo.fetchLastMessage(
                  //       senderId: currentUser.id,
                  //       receiverId: contact.uid),
                  // ),
                  //   ),
                  // );
                },
              );
            }
          }
          return Center(
            child: Text('Let\'s chat with your friends!'),
          );
        },
      ),
    ]);
  }
}
