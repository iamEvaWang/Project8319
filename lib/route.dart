import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/user_state.dart';

import 'Home/homepage.dart';
import 'Home/news_detail.dart';
import 'LoginPage/login_screen.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';


class RouterTable {
  static const String loginPage = '/login';
  static const String homePage = '/home';
  static const String newsDetailPage = '/newsDetailPage';
  static const String userState = '/userState';

  static Map<String, WidgetBuilder> routeTables = {
    loginPage :(context, {arguments}) => Login(),
    homePage :(context, {arguments}) => HomePage(),
    newsDetailPage : (context, {arguments}) => NewsDetailView(arguments: arguments),
    userState : (context, {arguments}) => UserState(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print(settings);
    return MaterialPageRoute(settings: settings,  builder: (context) {
      String routeName = routeHook(settings);
      if(routeTables[routeName] == null ){
        routeName = loginPage;
      }
      // Widget widget = routeTables[routeName]!(context);
      // return widget;

      Function pageBuilder = routeTables[routeName] as Function;
      return pageBuilder(context, arguments: settings.arguments);
    });
  }

  static String routeHook(RouteSettings settings) {
    //final token = Global.prefs.getString('token') ?? '';
    switch(settings.name){
      // need reroute
      case newsDetailPage:
        if (!isLogin) return userState;
      // case homePage:
      //   if (!isLogin) return loginPage;
    }
    return settings.name!;
  }


}






