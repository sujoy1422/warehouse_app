import 'package:warehouse_app/models/maintainance.dart';

abstract class MaintainanceRepository {
  Future<MaintainanceResponse> fetchMaintainanceResponse();
}
