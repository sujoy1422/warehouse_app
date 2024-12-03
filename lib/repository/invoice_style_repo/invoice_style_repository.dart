import 'package:warehouse_app/models/invoice_styles/invoice_styles.dart';

abstract class InvoiceStyleRepository {
  Future<List<InvoiceStyles>> fetchInvoiceStyle(
      String headerId, String articleNo, String lineId);
}
