import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Home/homepage.dart';
import 'LoginPage/login_screen.dart';
import 'Services/global_variables.dart';

class UserState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    isLogin = false;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot)
      {
        if(userSnapshot.data == null)
        {
          print('user is not logged in yet');
          return Login();
        }
        else if(userSnapshot.hasData)
        {
          print('user is already logged in yet');
          //return Screen();
          isLogin = true;
          return HomePage();
        }

        else if(userSnapshot.hasError)
        {
          return const Scaffold(
            body: Center(
              child: Text('An error has been occurred. Try again later'),
            ),
          );
        }

        else if(userSnapshot.connectionState == ConnectionState.waiting)
        {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('Something went wrong'),
          ),
        );
      },
    );
  }
}
