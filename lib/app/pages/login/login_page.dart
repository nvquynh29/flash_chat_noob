import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/sign_up/sign_up_page.dart';
import 'package:flash/app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends GetWidget<AuthController> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static final routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              controller.login(
                emailController.text.trim(),
                passwordController.text,
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text('SignUp'),
            onPressed: () {
              Get.toNamed(SignUpPage.routeName);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text('Google Login'),
            onPressed: signInWithGoogle,
          ),
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
