import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.size = 64,
    @required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    @required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: TextButton(
        child: SvgPicture.asset(iconSrc, color: iconColor),
        onPressed: press,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.all(15 / 64 * size),
          ),
          shape: MaterialStateProperty.all(
            CircleBorder(),
          ),
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    );
  }
}
