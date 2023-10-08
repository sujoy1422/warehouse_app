import 'package:warehouse_app/models/inspection_list/inspection_list.dart';
import 'package:warehouse_app/repository/inspection_list_repo/inspection_list_repository.dart';
import 'package:warehouse_app/service/web_service.dart';

class InspectionListRepoImpl implements InspectionListRepository {
  @override
  Future<List<InspectionList>> fetchInspectionList(String empNo) {
    return WebService().getInspectionList(empNo);
  }
}
