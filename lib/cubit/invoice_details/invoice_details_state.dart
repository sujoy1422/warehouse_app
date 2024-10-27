part of 'invoice_details_cubit.dart';

abstract class InvoiceDetailsState extends Equatable {
  const InvoiceDetailsState();

  @override
  List<Object> get props => [];
}

class InvoiceDetailsInitial extends InvoiceDetailsState {
  const InvoiceDetailsInitial();
}

class InvoiceDetailsLoading extends InvoiceDetailsState {
  const InvoiceDetailsLoading();
}

class InvoiceDetailsLoaded extends InvoiceDetailsState {
  final List<InvoiceDetails> invoiceDetails;
  const InvoiceDetailsLoaded(this.invoiceDetails);

  @override
  List<Object> get props => [invoiceDetails];
}

class InvoiceDetailsError extends InvoiceDetailsState {
  final String message;
  const InvoiceDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
