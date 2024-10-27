import 'package:warehouse_app/models/invoice_status/invoice_status.dart';

abstract class InvoiceStatusRepository {
  Future<InvoiceStatus> fetchInvoiceStatus(String headerId, String lineId);
}
