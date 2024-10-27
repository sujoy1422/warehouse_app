import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/repository/roll_data_repository/roll_data_repository.dart';

import '../../service/web_service.dart';

class RollDataRepoImpl implements RollDataRepository {
  @override
  Future<List<RollData>> fetchRollData(
    String headerId,
    String lineId,
    String showAll,
  ) {
    return WebService().getRollData(headerId, lineId,showAll);
  }
}
