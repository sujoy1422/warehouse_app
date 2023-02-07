import 'package:flutter/material.dart';

import 'logout_dialog.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Icon(
        Icons.logout, color: Colors.white,
        // "Logout",
        // style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        logoutDialog(context);
      },
    );
  }
}
