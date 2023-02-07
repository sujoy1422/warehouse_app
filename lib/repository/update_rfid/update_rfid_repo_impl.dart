import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repository.dart';

import '../../service/web_service.dart';

class UpdateDataRepoImpl implements UpdateDataRepository {
  @override
  Future<ResponseObject> fetchResponse(
      String detailsId, String rfid, String entryBy, String entryType) {
    return WebService().getResponseObject(detailsId, rfid, entryBy, entryType);
  }
}
