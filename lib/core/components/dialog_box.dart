
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.exit_to_app),
          content: Text(
            "Are you sure you want to exit?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
                // canPop = true;
              },
              child: Text('Yes'),
            ),
          ],
        );
      });
}
