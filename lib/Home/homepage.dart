import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user_state.dart';

class Screen extends StatefulWidget {

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'),),
      body: ElevatedButton(
        onPressed:(){
          _auth.signOut();
          Navigator.canPop(context) ? Navigator.pop(context) : null;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));

        },
        child: const Text('Logout'),
      ),
    );

  }
}
