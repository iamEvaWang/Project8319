
import 'package:flutter/material.dart';

Future<bool> showGotoLoginDialog(BuildContext context) async {
  bool result = await showDialog(
      context: context,
      builder:(ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Confirm'),
          content: Text('Login required for continue.'),
          titlePadding: EdgeInsets.all(24),
          contentPadding: EdgeInsets.all(16),
          actionsPadding: EdgeInsets.all(24),
          actionsAlignment: MainAxisAlignment.end,
          buttonPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Go to Login", style: TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
  return result;
}