import 'package:flash/app/app_routes.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/controllers/user_controller.dart';
import 'package:flash/app/providers/image_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageUploadProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "SF UI",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialBinding: BindingsBuilder(() {
          Get.put(UserController());
          Get.put(AuthController());
        }),
        initialRoute: '/',
        getPages: routes,
      ),
    );
  }
}
