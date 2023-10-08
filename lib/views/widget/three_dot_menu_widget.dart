import 'package:flutter/material.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/views/create_issuance.dart';
import 'package:warehouse_app/views/search_roll_location.dart';

import '../logout_dialog.dart';
import '../rfid_card_details.dart';

class PopUpMenu extends StatelessWidget {
  String text1;
  String text2;
  String text3;
  int value1;
  int value2;
  LoginObject? loginObject;
  PopUpMenu(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.value1,
      required this.value2,
      this.loginObject});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (item) {
        if (item == 0) {
          logoutDialog(context);
        } else if (item == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RfidCardDetails(),
            ),
          );
        } else if (item == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateIssuance(
                loginObject: loginObject,
              ),
            ),
          );
        } else if (item == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchRoll(),
            ),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(value: 0, child: Text('Logout')),
        PopupMenuItem<int>(value: value1, child: Text(text1)),
        PopupMenuItem<int>(value: value2, child: Text(text2)),
        PopupMenuItem<int>(value: 3, child: Text(text3)),
      ],
    );
  }
}
