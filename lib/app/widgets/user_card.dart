import 'package:flash/app/widgets/avatar.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Avatar avatar;
  final String title;
  final Widget subtitle;
  final bool isBoldText;
  final Widget trailing;
  final Function onTap;

  UserCard(
      {@required this.avatar,
      this.title,
      this.subtitle,
      this.isBoldText,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            avatar,
            SizedBox(width: 8.0,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    subtitle,
                  ],
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
