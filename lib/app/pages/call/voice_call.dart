import 'package:flash/app/pages/call/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class VoiceCall extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        Image.asset(
          "assets/images/full_image.png",
          fit: BoxFit.cover,
        ),
        // Black Layer
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jemmy \nWilliams",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Incoming 00:01".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Mic.svg",
                    ),
                    RoundedButton(
                      press: () {},
                      color: Colors.red,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Volume.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}