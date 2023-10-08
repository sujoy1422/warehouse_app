import 'package:warehouse_app/models/rfid_for_inspection/rfid_for_inspection.dart';

abstract class RfidForInspectionRepository {
  Future<RfidForInspection> fetchInspectionList(String rfidNo, String empNo);
}
