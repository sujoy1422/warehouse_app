// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:warehouse_app/models/login_object.dart';
import 'package:warehouse_app/views/home_page_view.dart';
import 'package:warehouse_app/views/maintenance.dart';
import 'package:warehouse_app/views/search_by_style.dart';
import 'package:warehouse_app/views/search_roll_location.dart';

import '../logout_dialog.dart';
import '../rfid_card_details.dart';

class PopUpMenu extends StatelessWidget {
  String text1;
  String text2;
  String text4;
  int value1;
  int value2;
  int value3;

  LoginObject? loginObject;
  PopUpMenu({
    super.key,
    required this.text1,
    required this.text2,
    required this.text4,
    required this.value1,
    required this.value2,
    required this.value3,
    this.loginObject,
  });

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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Maintainance(
                loginObject: loginObject,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else if (item == 3) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                loginObject: loginObject,
                showall: "Show All",
                visible: false,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchByStyle(),
              ));
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(value: 0, child: Text('Logout')),
        PopupMenuItem<int>(value: value1, child: Text(text1)),
        PopupMenuItem<int>(value: value2, child: Text(text2)),
        PopupMenuItem<int>(value: value3, child: Text(text4)),
      ],
    );
  }
}
