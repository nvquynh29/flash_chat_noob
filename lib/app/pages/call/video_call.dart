import 'package:flash/app/models/call.dart';
import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  final Call call;
  final Widget viewRows;
  final Widget toolbar;

  VideoCall({@required this.call, @required this.viewRows, @required this.toolbar});
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            widget.viewRows,
            widget.toolbar,
          ],
        ),
      ),
    );
  }
}
