import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lettersub_mobile_application/route.dart';
import 'package:lettersub_mobile_application/user_state.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp().then((_)=> runApp( MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LetterSub Mobile App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      //home: UserState(),
      //routes: RouterTable.routeTables,
      initialRoute: RouterTable.homePage,
      onGenerateRoute: RouterTable.onGenerateRoute,
    );
  }
}
