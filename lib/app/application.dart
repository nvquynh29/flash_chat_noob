import 'package:flash/app/app_routes.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
        Get.put(AuthController());
      }),
      initialRoute: '/',
      getPages: routes,
    );
  }
}
