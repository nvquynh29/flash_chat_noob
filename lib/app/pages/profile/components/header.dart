import 'package:flash/app/utils/media.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double ratio = media.ratio;

    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: MyClipper(ratio: ratio),
      child: Container(
        width: double.infinity,
        height: 350 * ratio,
        color: Colors.green,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final double ratio;
  MyClipper({this.ratio});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - ratio * 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 170 * ratio);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
