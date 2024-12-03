import 'package:warehouse_app/models/response_object.dart';

abstract class UpdateDataRepository {
  Future<ResponseObject> fetchResponse(
      String detailsId, String rfid, String entryBy, String entryType, String pocId, String checkStatus);
}
