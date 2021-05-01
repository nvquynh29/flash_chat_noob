import 'package:flash/app/pages/call/call_page.dart';
import 'package:flash/app/pages/chat/chat_page.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/loading.dart';
import 'package:flash/app/pages/login/login_page.dart';
import 'package:flash/app/pages/profile/profile.dart';
import 'package:flash/app/pages/root.dart';
import 'package:flash/app/pages/search/search_page.dart';
import 'package:flash/app/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: Root.routeName, page: () => Root()),
  GetPage(name: HomePage.routeName, page: () => HomePage()),
  GetPage(name: LoginPage.routeName, page: () => LoginPage()),
  GetPage(name: SignUpPage.routeName, page: () => SignUpPage()),
  GetPage(name: SearchPage.routeName, page: () => SearchPage()),
  GetPage(name: ChatPage.routeName, page: () => ChatPage()),
  // GetPage(name: VoiceCall.routeName, page: () => VoiceCall()),
  // GetPage(name: VideoCall.routeName, page: () => VideoCall()),
  GetPage(name: Loading.routeName, page: () => Loading()),
  GetPage(name: CallPage.routeName, page: () => CallPage()),
  GetPage(name: Profile.routeName, page: () => Profile())
];
