import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetWidget<AuthController> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  static final routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            controller: rePasswordController,
            decoration: InputDecoration(hintText: 'Confirm Password'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              controller.createUser(
                email: emailController.text,
                name: nameController.text,
                password: passwordController.text,
              );
              Get.offAllNamed(HomePage.routeName);
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
