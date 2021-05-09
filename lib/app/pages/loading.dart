import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  static final String routeName = '/loading';
  @override
  Widget build(BuildContext context) {
    var spinkit = SpinKitPouringHourglass(
      color: Colors.green,
      duration: Duration(seconds: 2),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spinkit,
            SizedBox(height: 50),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
