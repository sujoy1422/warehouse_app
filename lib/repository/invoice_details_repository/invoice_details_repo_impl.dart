import 'package:warehouse_app/models/invoice_details.dart';
import 'package:warehouse_app/repository/invoice_details_repository/invoice_details_repository.dart';

import '../../service/web_service.dart';

class InvoiceDetailsRepoImpl implements InvoiceDetailsRepository {
  @override
  Future<List<InvoiceDetails>> fetchInvoiceDetails(
    String headerId
  ) {
    return WebService().getFabricCode(headerId);
  }
}
