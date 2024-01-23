import 'package:warehouse_app/models/invoice_status/invoice_status.dart';
import 'package:warehouse_app/repository/invoice_status_repo/invoice_status_repository.dart';

import '../../service/web_service.dart';

class InvoiceStatusRepoImpl implements InvoiceStatusRepository {
  @override
  Future<InvoiceStatus> fetchInvoiceStatus(String headerId) {
    return WebService().getInvoiceStatus(headerId);
  }
}
