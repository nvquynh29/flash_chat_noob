import 'package:flash/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flash/app/utils/media.dart';

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

  Media media;
  double r;

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    r = media.ratio;

    return hasStories
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: blue_story, width: r),
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
      backgroundColor: Colors.white,
      radius: radius,
      backgroundImage: imageURL != null ? NetworkImage(imageURL) : null,
      child: imageURL == null
          ? Icon(Icons.person, color: Colors.blueGrey, size: radius * 1.5,)
          : null,
    );
  }

  Widget buildStatusAvatar() {
    return Stack(
      children: [
        buildCircleAvatar(),
        online
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: radius * 0.6,
                  height: radius * 0.6,
                  decoration: BoxDecoration(
                      color: green,
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: r * 3)),
                ),
              )
            : Container(),
      ],
    );
  }
}
