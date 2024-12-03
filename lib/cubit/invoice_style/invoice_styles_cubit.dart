import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/invoice_styles/invoice_styles.dart';

import '../../repository/invoice_style_repo/invoice_style_repository.dart';

part 'invoice_styles_state.dart';

class InvoiceStylesCubit extends Cubit<InvoiceStylesState> {
  final InvoiceStyleRepository _invoiceStyleRepository;

  InvoiceStylesCubit(this._invoiceStyleRepository)
      : super(const InvoiceStylesInitial());

  Future<void> getInvoiceStyle(
      String headerId, String articleNo, String lineId) async {
    try {
      emit(const InvoiceStylesLoading());
      final invoiceStyles = await _invoiceStyleRepository.fetchInvoiceStyle(
          headerId, articleNo, lineId);
      emit(InvoiceStylesLoaded(invoiceStyles));
    } on Exception {
      emit(const InvoiceStylesError("Couldn't Fetch data!"));
    }
  }
}
