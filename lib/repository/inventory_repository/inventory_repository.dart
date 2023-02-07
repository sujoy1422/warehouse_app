import 'package:warehouse_app/models/inventory.dart';

abstract class InventoryDataRepository {
  Future<List<Inventory>> fetchInventoryData(String orgId);
}
