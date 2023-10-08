
import 'package:warehouse_app/repository/rfid_status_repo/rfid_status_repo.dart';

import '../../models/rfid_status/rfid_status.dart';
import '../../service/web_service.dart';

class RfidStatusRepoImpl implements RfidStatusRepository {
  @override
  Future<RfidStatus> fetchRfidStatus(
      String rfidNo) {
    return WebService().getRfidStatus(rfidNo);
  }
}
