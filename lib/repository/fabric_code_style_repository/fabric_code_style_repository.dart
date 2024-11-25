import 'package:warehouse_app/models/fabric_code_style/fabric_code_style.dart';

abstract class FabricCodeStyleRepository {
  Future<List<FabricCodeStyle>> fetchInvoiceStatus(String headerId, String articleNo);
}
