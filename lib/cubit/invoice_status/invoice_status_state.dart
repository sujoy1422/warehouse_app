part of 'invoice_status_cubit.dart';

abstract class InvoiceStatusState extends Equatable {
  const InvoiceStatusState();

  @override
  List<Object> get props => [];
}

class InvoiceStatusInitial extends InvoiceStatusState {
  const InvoiceStatusInitial();
}

class InvoiceStatusLoading extends InvoiceStatusState {
  const InvoiceStatusLoading();
}

class InvoiceStatusLoaded extends InvoiceStatusState {
  final InvoiceStatus? invoiceStatus;
  const InvoiceStatusLoaded(this.invoiceStatus);

  @override
  List<Object> get props => [invoiceStatus??""];
}

class InvoiceStatusError extends InvoiceStatusState {
  final String message;
  const InvoiceStatusError(this.message);

  @override
  List<Object> get props => [message];
}
