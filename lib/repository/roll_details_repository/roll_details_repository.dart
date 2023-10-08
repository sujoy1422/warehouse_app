import '../../models/roll_details.dart';

abstract class RollDetailsRepository {
  Future<List<RollDetails>> fetchRollDetails(String rollNo);
}
