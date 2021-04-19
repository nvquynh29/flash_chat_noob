import 'package:flash/app/constants/colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String imageURL;
  final bool online;
  final bool hasStories;

  Avatar(
      {this.radius,
      this.imageURL,
      this.online = false,
      this.hasStories = false});

  @override
  Widget build(BuildContext context) {
    return hasStories
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: blue_story, width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: buildStatusAvatar(),
            ),
          )
        : buildStatusAvatar();
  }

  Widget buildCircleAvatar() {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageURL != null ? NetworkImage(imageURL) : null,
      child: imageURL == null
          ? Icon(Icons.person_outline, size: radius * 2)
          : null,
    );
  }

  Widget buildStatusAvatar() {
    return Stack(
      children: [
        buildCircleAvatar(),
        online
            ? Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: green,
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 3)),
                ),
              )
            : Container(),
      ],
    );
  }
}
