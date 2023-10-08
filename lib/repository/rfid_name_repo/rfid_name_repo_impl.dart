import 'package:warehouse_app/models/rfid_name.dart';
import 'package:warehouse_app/repository/rfid_name_repo/rfid_name_repository.dart';

import '../../service/web_service.dart';

class RfidNameRepoImpl implements RfidNameRepository {
  @override
  Future<RfidName> fetchRfidName(String rfidNo) {
    return WebService().getRfidName(rfidNo);
  }
}
