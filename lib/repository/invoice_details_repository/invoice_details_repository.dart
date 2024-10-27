import 'package:warehouse_app/models/invoice_details.dart';

abstract class InvoiceDetailsRepository {
  Future<List<InvoiceDetails>> fetchInvoiceDetails(String headerId);
}
