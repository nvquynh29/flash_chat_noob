import 'package:flash/app/utils/media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialButton extends StatelessWidget {
  const DialButton({
    Key key,
    @required this.iconSrc,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String iconSrc, text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;
    return SizedBox(
      width: r * 110,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: r * 20,
            ),
          ),
        ),
        onPressed: press,
        child: Column(
          children: [
            SvgPicture.asset(
              iconSrc,
              color: Colors.white,
              height: r * 34,
            ),
            SizedBox(
              height: r * 12,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: r * 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
