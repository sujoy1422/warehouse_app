import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/repository/insert_inspection_repo/insert_inspection_repository.dart';
import 'package:warehouse_app/service/web_service.dart';

class InsertInspectionRepoImpl implements InsertInspectionRepository {
  @override
  Future<ResponseObject> fetchReponse(String rfidNo, String empNo) {
    return WebService().getReponse(rfidNo, empNo);
  }
}
