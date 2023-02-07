import 'package:flutter/material.dart';

import 'login_screen.dart';

Future<dynamic> logoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Warning!'),
      content: const Text('Do you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            // Others.notificationPage.value.clear();
            // Others.notificationStatus.value.clear();
            // Others.notificationsData.value.clear();
            // Others.color.value.clear();
            // Others.item.value = 0;
            id = "";
            pass = "";
            Navigator.of(context).pop(true);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (Route<dynamic> route) => false);

            // inTime = null;
            // outTime = null;
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
