import 'package:warehouse_app/models/inventory.dart';
import 'package:warehouse_app/repository/inventory_repository/inventory_repository.dart';
import 'package:warehouse_app/service/web_service.dart';

class InventoryDataRepoImpl implements InventoryDataRepository {
  @override
  Future<List<Inventory>> fetchInventoryData(
    String orgId,
  ) {
    return WebService().getInventoryData(orgId);
  }
}
