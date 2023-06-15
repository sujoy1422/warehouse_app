import 'package:warehouse_app/models/roll_data.dart';

abstract class RollDataRepository {
  Future<List<RollData>> fetchRollData(String headerId, String showAll);
}
