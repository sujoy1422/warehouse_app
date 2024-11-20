import 'package:warehouse_app/models/maintainance.dart';
import 'package:warehouse_app/repository/maintainance_repo/maintainance_repository.dart';

import '../../service/web_service.dart';

class MaintainanceRepoImpl implements MaintainanceRepository {
  @override
  Future<MaintainanceResponse> fetchMaintainanceResponse() {
    return WebService().maintainance();
  }
}
