import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/loading.dart';
import 'package:flash/app/pages/sign_up/sign_up_page.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flash/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget<AuthController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static final routeName = '/login';
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: r * 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/login_logo.png',
                  height: r * 120,
                ),
                SizedBox(height: r * 20),
                _EmailField(emailController: emailController),
                SizedBox(height: r * 20),
                _PasswordField(passwordController: passwordController),
                SizedBox(
                  height: r * 10,
                ),
                _LoginButton(
                  r: r,
                  controller: controller,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(
                  height: r * 10,
                ),
                _GoogleLoginButton(controller: controller, r: r),
                SizedBox(
                  height: r * 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have account? ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(SignUpPage.routeName),
                      child: Text(
                        ' SignUp',
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

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key key,
    @required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.3),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    Key key,
    @required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.3),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key key,
    @required this.r,
    @required this.controller,
    @required this.emailController,
    @required this.passwordController,
  }) : super(key: key);

  final double r;
  final AuthController controller;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: const Color(0xFFFFD600),
      ),
      child: Container(
        child: Text(
          'LOGIN',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        width: r * 200,
        height: r * 48,
        alignment: Alignment.center,
      ),
      onPressed: () => controller.login(
        emailController.text.trim(),
        passwordController.text,
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({
    Key key,
    @required this.controller,
    @required this.r,
  }) : super(key: key);

  final AuthController controller;
  final double r;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        controller.logInWithGoogle().whenComplete(() async {
          if (FirebaseAuth.instance.currentUser != null) {
            Get.toNamed(Loading.routeName);
            await UserRepository()
                .createUserFromGoogle(
                  FirebaseAuth.instance.currentUser,
                )
                .whenComplete(
                  () => Get.offAllNamed(HomePage.routeName),
                );
          }
        });
      },
      icon: Icon(
        FontAwesomeIcons.google,
        size: r * 20,
      ),
      label: Container(
        width: r * 170,
        height: r * 48,
        alignment: Alignment.center,
        child: Text(
          'SIGN IN WITH GOOGLE',
          style: TextStyle(
            color: Colors.white,
            fontSize: r * 15,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: Theme.of(context).accentColor,
      ),
    );
  }
}
