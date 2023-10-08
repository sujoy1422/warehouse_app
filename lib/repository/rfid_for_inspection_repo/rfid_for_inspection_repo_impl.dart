import 'package:warehouse_app/models/rfid_for_inspection/rfid_for_inspection.dart';
import 'package:warehouse_app/repository/rfid_for_inspection_repo/rfid_for_inspection_repository.dart';

import '../../service/web_service.dart';

class RfidForInspectionRepoImpl implements RfidForInspectionRepository {
  @override
  Future<RfidForInspection> fetchInspectionList(String rfidNo, String empNo) {
    return WebService().getRfidInspectionList(rfidNo, empNo);
  }
}
