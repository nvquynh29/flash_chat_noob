import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final double iconSize;
  final BoxBorder border;
  final Color color;

  CircleIconButton({this.icon, this.onPressed, this.iconSize, this.border, this.color});

  CircleIconButton.border({
    @required this.icon,
    @required this.onPressed,
    this.color,
    this.iconSize,
  }) : this.border = Border.all(color: const Color.fromRGBO(185, 192, 217, 1));

  @override
  Widget build(BuildContext context) {
    final iconSize = this.iconSize ?? 32;
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor.withOpacity(0.7),
        border: border,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: iconSize,
        splashRadius: 30,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
