import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/invoice_status/invoice_status.dart';
import 'package:warehouse_app/repository/invoice_status_repo/invoice_status_repository.dart';

part 'invoice_status_state.dart';

class InvoiceStatusCubit extends Cubit<InvoiceStatusState> {

  final InvoiceStatusRepository _invoiceStatusRepository;

  InvoiceStatusCubit(this._invoiceStatusRepository)
      : super(const InvoiceStatusInitial());

  Future<void> getInvoiceStatus(String headerId) async {
    try {
      emit(const InvoiceStatusLoading());
      final invoiceStatus =
          await _invoiceStatusRepository.fetchInvoiceStatus(headerId);
      emit(InvoiceStatusLoaded(invoiceStatus));
    } on Exception {
      emit(const InvoiceStatusError("Couldn't Fetch data!"));
    }
  }
}
