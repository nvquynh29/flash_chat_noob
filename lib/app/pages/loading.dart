import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  static final routeName = '/loading';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
