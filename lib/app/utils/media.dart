import 'package:flutter/material.dart';

class Media {
  MediaQueryData _mediaQueryData;
  double width;
  double height;
  bool isHorizontal;
  bool isVertical;
  double ratio;

  Media(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    isVertical = _mediaQueryData.orientation == Orientation.portrait;
    isHorizontal = _mediaQueryData.orientation == Orientation.landscape;
    ratio = (isVertical ? height : width) * 0.0012;
  }
}