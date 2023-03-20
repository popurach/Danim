import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneButtonCupertinoAlertDiaglog {
  void showFeedBack(BuildContext context, String message) {
    final alert = CupertinoAlertDialog(
      content: Text(
        message,
        style: TextStyle(fontSize: 30),
      ),
      actions: [
        CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
