import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  static final routeName = '/loading';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text('Please wait...', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            Text('It might take a while', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }
}
