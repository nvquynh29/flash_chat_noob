import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/constants/data.dart';
import 'package:flash/app/pages/meeting/meeting.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r * 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Meeting.routeName),
                  child: Container(
                    width: r * 60,
                    height: r * 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: grey,
                    ),
                    child: Icon(
                      Icons.video_call,
                      size: r * 35,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(height: r * 15),
                Text(
                  'Create Room',
                  style: TextStyle(fontSize: r * 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              userStories.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(right: r * 10),
                  child: Column(
                    children: [
                      Avatar(
                        imageURL: userStories[index]['img'],
                        radius: r * 30,
                        online: userStories[index]['online'],
                        hasStories: userStories[index]['story'],
                      ),
                      SizedBox(height: userStories[index]['story'] ? r * 8 : r * 16),
                      Text(
                        userStories[index]['name'],
                        style: TextStyle(fontSize: r * 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
