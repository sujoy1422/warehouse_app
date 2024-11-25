import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_app/models/fabric_code_style/fabric_code_style.dart';
import 'package:warehouse_app/models/inspection_list/inspection_list.dart';
import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/models/invoice_details.dart';
import 'package:warehouse_app/models/invoice_status/invoice_status.dart';
import 'package:warehouse_app/models/maintainance.dart';
import 'package:warehouse_app/models/pallet_info/pallet_info.dart';
import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/models/rfid_for_inspection/rfid_for_inspection.dart';
import 'package:warehouse_app/models/rfid_name.dart';
import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/models/roll_details.dart';
import 'package:warehouse_app/models/style_wise_count.dart';
import 'package:warehouse_app/models/style_wise_roll.dart';

import '../models/login_object.dart';
import '../models/rfid_status/rfid_status.dart';
import '../models/searchable_roll_list.dart';
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
      debugPrint("Login Object\n" + response.toString());
      if (response.data != null) {
        return LoginObject?.fromJson(response.data);
      } else {
        throw Exception("Authentication error!");
      }
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

  Future<List<StyleWiseRoll>> getStyleWiseRoll(String systemId) async {
    var formDate = FormData.fromMap({
      'system_id': systemId,
    });

    final response = await dio.post(
      Constants.getStylewiseRoll,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable inventory = response.data;
      return inventory.map((e) => StyleWiseRoll.fromJson(e)).toList();
    } else {
      throw Exception("roll data fetch error!");
    }
  }

  Future<List<StyleWiseCount>> getStyleWiseCount() async {
    final response = await dio.get(
      Constants.getStyleWiseCount,
    );

    if (response.statusCode == 200) {
      Iterable inventory = response.data;
      return inventory.map((e) => StyleWiseCount.fromJson(e)).toList();
    } else {
      throw Exception("count data fetch error!");
    }
  }

  Future<List<RollData>> getRollData(
      String headerId, String articleNo, String lineId, String showAll) async {
    var formDate = FormData.fromMap({
      'header_id': headerId,
      'line_id': lineId,
      'article_no': articleNo,
      'show_all': showAll,
    });

    final response = await dio.post(
      Constants.rollDataUrl,
      data: formDate,
    );
    debugPrint("response: $response");

    if (response.statusCode == 200) {
      Iterable rollData = response.data;
      return rollData.map((e) => RollData.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<RfidName> getRfidName(String rfidNo) async {
    debugPrint("hererrerer");
    var formDate = FormData.fromMap({
      'rfid_no': rfidNo,
    });

    final response = await dio.post(
      Constants.getRfidName,
      data: formDate,
    );
    debugPrint("rfid_name ${response.statusCode}");

    if (response.statusCode == 200) {
      return RfidName.fromJson(response.data);
    } else {
      throw Exception("RFID name fetch error!");
    }
  }

  Future<ResponseObject> getReponse(String rfidNo, String empNo) async {
    var formDate = FormData.fromMap({
      'rfid_epc': rfidNo,
      'emp_no': empNo,
    });

    final response = await dio.post(
      Constants.insertIssueanceList,
      data: formDate,
    );
    debugPrint(response.toString());

    if (response.statusCode == 200) {
      return ResponseObject.fromJson(response.data);
    } else {
      throw Exception("RFID name fetch error!");
    }
  }

  Future<List<InspectionList>> getInspectionList(String empNo) async {
    debugPrint("hererrerer");
    var formDate = FormData.fromMap({
      'pallet_id': empNo,
    });

    final response = await dio.post(
      Constants.getInspectionList,
      data: formDate,
    );
    debugPrint("xx $response");

    if (response.statusCode == 200) {
      Iterable rollData = response.data;
      return rollData.map((e) => InspectionList.fromJson(e)).toList();
    } else {
      throw Exception("Inspection list fetch error!");
    }
  }

  Future<PalletInfo> getPalletInfo(String palletInfo) async {
    var formDate = FormData.fromMap({
      'pallet_id': palletInfo,
    });

    final response = await dio.post(
      Constants.getPalletInfo,
      data: formDate,
    );

    if (response.statusCode == 200) {
      return PalletInfo.fromJson(response.data);
    } else {
      throw Exception("RFID name fetch error!");
    }
  }

  Future<List<RollDetails>> getRollDetails(String rollNo) async {
    var formDate = FormData.fromMap({
      'roll_no': rollNo,
    });

    final response = await dio.post(
      Constants.rollDetailsUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable rollDetails = response.data;
      return rollDetails.map((e) => RollDetails.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<List<SearchableRollList>> getSearchableRollList() async {
    // var formDate = FormData.fromMap({
    //   'roll_no': rollNo,
    // });

    final response = await dio.get(
      Constants.searchAbleRollList,
      // data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable rollDetails = response.data;
      return rollDetails.map((e) => SearchableRollList.fromJson(e)).toList();
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

  Future<RfidStatus> getRfidStatus(String rfidNo) async {
    var formDate = FormData.fromMap({'rfid_no': rfidNo});

    final response = await dio.post(
      Constants.getRfidStatus,
      data: formDate,
    );

    if (response.statusCode == 200) {
      return RfidStatus.fromJson(response.data);
    } else {
      throw Exception("RFID status exception!");
    }
  }

  Future<RfidForInspection> getRfidInspectionList(
      String rfidNo, String empNo) async {
    var formDate = FormData.fromMap({'rfid_no': rfidNo, 'emp_no': empNo});

    final response = await dio.post(
      Constants.rfidForInspection,
      data: formDate,
    );

    if (response.statusCode == 200) {
      return RfidForInspection.fromJson(response.data);
    } else {
      throw Exception("RFID inspection list exception!");
    }
  }

  Future<InvoiceStatus> getInvoiceStatus(
      String headerId, String articleNo, String lineId) async {
    var formDate = FormData.fromMap(
        {'header_id': headerId, 'article_no': articleNo, 'line_id': lineId});

    final response = await dio.post(
      Constants.getInvoiceStatus,
      data: formDate,
    );

    if (response.statusCode == 200) {
      debugPrint("state_res_2${response.toString()}");
      return InvoiceStatus.fromJson(response.data);
    } else {
      throw Exception("Invoice Status exception!");
    }
  }

  Future<List<InvoiceDetails>> getFabricCode(String headerId) async {
    var formDate = FormData.fromMap({'header_id': headerId});

    final response = await dio.post(
      Constants.invoiceDetailsUrl,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable invoiceDetails = response.data;
      return invoiceDetails.map((e) => InvoiceDetails.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<List<FabricCodeStyle>> getFabricCodeStyle(String headerId, String articleNo) async {
    var formDate = FormData.fromMap({'header_id': headerId, 'article_no' : articleNo});

    final response = await dio.post(
      Constants.fabricCodeStyle,
      data: formDate,
    );

    if (response.statusCode == 200) {
      Iterable invoiceDetails = response.data;
      return invoiceDetails.map((e) => FabricCodeStyle.fromJson(e)).toList();
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }

  Future<MaintainanceResponse> maintainance() async {
    final response = await dio.post(
      Constants.getMaintainanceStatus,
    );

    if (response.statusCode == 200) {
      debugPrint("state_res_2${response.toString()}");
      return MaintainanceResponse.fromJson(response.data);
    } else {
      throw Exception("Inventory data fetch error!");
    }
  }
}
