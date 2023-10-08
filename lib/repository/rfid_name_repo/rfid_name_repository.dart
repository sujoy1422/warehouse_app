import 'package:warehouse_app/models/rfid_name.dart';

abstract class RfidNameRepository {
  Future<RfidName> fetchRfidName(String rfidNo);
}
