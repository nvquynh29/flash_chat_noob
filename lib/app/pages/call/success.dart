import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Success extends StatelessWidget {
  static final String routeName = '/success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you for your feedback',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/feedback.jpg',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                child: Text(
                  'Home Page',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onPressed: () => Get.offAllNamed(HomePage.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
