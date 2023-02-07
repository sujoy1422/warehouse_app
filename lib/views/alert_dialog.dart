import 'package:flutter/material.dart';

alertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context1) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context1).pop();
              // FocusScope.of(conte xt).unfocus();
            },
          ),
        ],
      );
    },
  );
}
