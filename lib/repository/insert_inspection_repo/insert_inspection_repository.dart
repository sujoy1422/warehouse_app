import 'package:warehouse_app/models/response_object.dart';

abstract class InsertInspectionRepository {
  Future<ResponseObject> fetchReponse(String rfidNo, String empNo);
}
