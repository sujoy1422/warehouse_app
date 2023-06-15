import 'package:dio/dio.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/models/roll_data.dart';

import '../models/login_object.dart';
import '../models/profile.dart';
import '../utils/constants.dart';

class WebService {
  var dio = Dio();

  Future<LoginObject> getLoginData(
      String empNo, String pass, String orgID, String empCat) async {
    var formDate = FormData.fromMap({
      'emp_no': empNo,
      'pass': pass,
      'org_id': orgID,
      'emp_cat': empCat,
    });

    final response = await dio.post(
      Constants.authApiUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      print("Login Object\n" + response.toString());

      return LoginObject.fromJson(response.data);
    } else {
      throw Exception("Authentication error!");
    }
  }

  Future<List<Inventory>> getInventoryData(String orgId) async {
    var formDate = FormData.fromMap({
      'org_id': orgId,
    });

    final response = await dio.post(
      Constants.inventoryUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable inventory = response.data;
      return inventory.map((e) => Inventory.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<List<RollData>> getRollData(String headerId, String showAll) async {
    var formDate = FormData.fromMap({
      'header_id': headerId,
      'show_all': showAll,
    });

    final response = await dio.post(
      Constants.rollDataUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable rollData = response.data;
      return rollData.map((e) => RollData.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  
  Future<ResponseObject> getResponseObject(
      String detailsId, String rfid, String entryBy, String entryType) async {
    var formDate = FormData.fromMap({
      'detail_id': detailsId,
      'rfid': rfid,
      'entry_by': entryBy,
      'entry_type': entryType,
    });

    final response = await dio.post(
      Constants.updateRfidUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      return ResponseObject.fromJson(response.data);
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<Profile> getProfileData(String? empNo) async {
    var formDate = FormData.fromMap({
      'emp_no': empNo,
    });

    final response = await dio.post(
      Constants.profileApiUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      print("Profile Object\n" + response.toString());

      return Profile.fromJson(response.data);
    } else {
      throw Exception("Profile error!");
    }
  }
}
