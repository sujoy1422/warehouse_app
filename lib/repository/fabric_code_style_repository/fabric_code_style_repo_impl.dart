import 'package:warehouse_app/models/fabric_code_style/fabric_code_style.dart';
import 'package:warehouse_app/repository/fabric_code_style_repository/fabric_code_style_repository.dart';

import '../../service/web_service.dart';

class FabricCodeStyleRepoImpl implements FabricCodeStyleRepository {
  @override
  Future<List<FabricCodeStyle>> fetchInvoiceStatus(
      String headerId, String articleNO) {
    return WebService().getFabricCodeStyle(headerId, articleNO);
  }
}
