class Constants {
  static const appTitle = "Warehouse";
  static const appVersion = "App Version 1.0.0";

//Api Url
  static const baseUrl =
      "https://homeoffice.mj-group.com/SelfService/new_api/api_mj_app/";

  static const baseUrlWarehouse =
      "https://homeoffice.mj-group.com/warehouse_api/";

  static const authApiUrl = "${baseUrl}app_auth.php";
  static const inventoryUrl = "${baseUrlWarehouse}get_inv_data.php";
  static const rollDataUrl = "${baseUrlWarehouse}get_roll_data.php";
  static const updateRfidUrl = "${baseUrlWarehouse}update_rfid.php";
  static const profileApiUrl = "${baseUrl}profile_data.php";
}
