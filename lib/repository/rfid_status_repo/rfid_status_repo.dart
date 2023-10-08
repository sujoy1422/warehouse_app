

import '../../models/rfid_status/rfid_status.dart';

abstract class RfidStatusRepository {
  Future<RfidStatus> fetchRfidStatus(
      String rfidNo);
}
