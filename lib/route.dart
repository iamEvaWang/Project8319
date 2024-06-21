import 'package:flutter/material.dart';

import 'Home/homepage.dart';
import 'LoginPage/login_screen.dart';
import 'package:lettersub_mobile_application/Services/global_variables.dart';


class RouterTable {
  static const String loginPage = '/login';
  static const String homePage = '/home';

  static Map<String, WidgetBuilder> routeTables = {
    loginPage :(context) => Login(),
    homePage :(context) => HomePage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(settings: settings,  builder: (context) {
      String routeName = routeHook(settings);
      if(routeTables[routeName] == null ){
        routeName = loginPage;
      }
      Widget widget = routeTables[routeName]!(context);
      return widget;
    });
  }

  static String routeHook(RouteSettings settings) {
    //final token = Global.prefs.getString('token') ?? '';
    switch(settings.name){
      case homePage:
        if (!isLogin) return loginPage;
    }
    return settings.name!;
  }


}






