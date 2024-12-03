class Constants {
  static const appTitle = "Warehouse";
  static const appVersion = "App Version 1.6.5";

// //Api Url
//   static const baseUrl =
//       "https://homeoffice.mj-group.com/SelfService/new_api/api_mj_app/";

  // static const baseUrlWarehouse = "http://192.168.9.247/warehouse_api/";
  static const baseUrlWarehouse =
      "http://192.168.9.247/warehouse_api/warehouse_main/";
  // static const baseUrlWarehouse = "https://homeoffice.mj-group.com/warehouse_api/";

  static const authApiUrl = "${baseUrlWarehouse}app_auth2.php";
  static const inventoryUrl = "${baseUrlWarehouse}get_inv_data.php";
  static const rollDataUrl = "${baseUrlWarehouse}get_roll_data.php";
  static const rollDetailsUrl = "${baseUrlWarehouse}get_roll_details.php";
  static const invoiceDetailsUrl = "${baseUrlWarehouse}get_fabric_code.php";
  static const fabricCodeStyle = "${baseUrlWarehouse}get_fabric_code_style.php";
  static const searchAbleRollList =
      "${baseUrlWarehouse}get_searchable_roll_list.php";
  static const rollDataUrlShowAll = "${baseUrlWarehouse}get_roll_data2.php";
  static const updateRfidUrl = "${baseUrlWarehouse}update_rfid.php";
  static const getRfidStatus = "${baseUrlWarehouse}get_rfid_status.php";
  static const rfidForInspection = "${baseUrlWarehouse}rfid_for_inspection.php";
  static const getRfidName = "${baseUrlWarehouse}get_rfid_name.php";
  static const getInspectionList = "${baseUrlWarehouse}get_inspection_list.php";
  static const getPalletInfo = "${baseUrlWarehouse}get_pallet_info.php";
  static const insertIssueanceList =
      "${baseUrlWarehouse}insert_inssuance_list.php";
  static const getStylewiseRoll = "${baseUrlWarehouse}get_stylewise_roll.php";
  static const getStyleWiseCount =
      "${baseUrlWarehouse}get_style_wise_count.php";

  static const getInvoiceStatus = "${baseUrlWarehouse}get_invoice_status.php";
  static const getMaintainanceStatus = "${baseUrlWarehouse}maintainance.php";
  static const getInvoiceStyle = "${baseUrlWarehouse}get_invoice_styles.php";

  // static const profileApiUrl = "${baseUrl}profile_data.php";
}
