
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/invoice_details.dart';
import 'package:warehouse_app/repository/invoice_details_repository/invoice_details_repository.dart';

part 'invoice_details_state.dart';

class InvoiceDetailsCubit extends Cubit<InvoiceDetailsState> {
  final InvoiceDetailsRepository _invoiceDetailsRepository;

  InvoiceDetailsCubit(this._invoiceDetailsRepository)
      : super(const InvoiceDetailsInitial());

  Future<void> getInvoiceDetails(String headerId) async {
    try {
      emit(const InvoiceDetailsLoading());
      final invoiceDetailsData =
          await _invoiceDetailsRepository.fetchInvoiceDetails(headerId);
      emit(InvoiceDetailsLoaded(invoiceDetailsData));
    } on Exception {
      emit(const InvoiceDetailsError("Couldn't Fetch data!"));
    }
  }
}