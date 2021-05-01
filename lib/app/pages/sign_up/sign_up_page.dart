import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/loading.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash/app/utils/extensions.dart';

class SignUpPage extends GetWidget<AuthController> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  static final routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;

    return Scaffold(
      body: Align(
        alignment: Alignment(0, -1 / 4),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: r * 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InputField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Full Name',
                  controller: nameController,
                ),
                _InputField(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  controller: emailController,
                ),
                _InputField(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                _InputField(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  controller: rePasswordController,
                  obscureText: true,
                ),
                SizedBox(height: r * 30),
                Container(
                  width: r * 100,
                  height: r * 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      nameController.isValid;
                      // Check valid
                      Get.toNamed(Loading.routeName);
                      controller
                          .createUser(
                            email: emailController.text,
                            name: nameController.text,
                            password: passwordController.text,
                          )
                          .whenComplete(
                              () => Get.offAllNamed(HomePage.routeName));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: r * 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account? ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.offAllNamed(LoginPage.routeName),
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final String hintText;
  final bool obscureText;

  _InputField(
      {this.controller,
      this.prefixIcon,
      this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
