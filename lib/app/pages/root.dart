import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/models/user_model.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Root extends StatelessWidget {
  static final routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Obx(() => (Get.find<AuthController>().user != null)
        ? HomePage()
        : LoginPage());
  }
}
