import 'package:warehouse_app/models/roll_details.dart';
import 'package:warehouse_app/repository/roll_details_repository/roll_details_repository.dart';

import '../../service/web_service.dart';

class RollDetailsRepoImpl implements RollDetailsRepository {
  @override
  Future<List<RollDetails>> fetchRollDetails(String rollNo) {
    return WebService().getRollDetails(rollNo);
  }
}
