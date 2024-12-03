import 'package:warehouse_app/models/invoice_styles/invoice_styles.dart';

import '../../service/web_service.dart';
import 'invoice_style_repository.dart';

class InvoiceStyleRepoImpl implements InvoiceStyleRepository {
  @override
  Future<List<InvoiceStyles>> fetchInvoiceStyle(
      String headerId, String articleNO, String lineId) {
    return WebService().getInvoiceStyle(headerId, articleNO, lineId);
  }
}
