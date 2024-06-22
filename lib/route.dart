import 'package:flutter/material.dart';

import 'package:lettersub_mobile_application/user_state.dart';
import 'Home/homepage.dart';
import 'Home/news_detail.dart';
import 'LoginPage/login_screen.dart';


class RouterTable {
  static const String loginPage = '/login';
  static const String homePage = '/home';
  static const String newsDetailPage = '/newsDetailPage';
  static const String userState = '/userState';

  static Map<String, WidgetBuilder> routeTables = {
    loginPage: (context) => Login(),
    homePage: (context) => HomePage(),
    newsDetailPage: (context) => NewsDetailView(),
    userState: (context) => UserState(),
  };

}