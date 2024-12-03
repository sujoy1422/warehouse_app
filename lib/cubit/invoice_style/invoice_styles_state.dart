part of 'invoice_styles_cubit.dart';

abstract class InvoiceStylesState extends Equatable {
  const InvoiceStylesState();

  @override
  List<Object> get props => [];
}

class InvoiceStylesInitial extends InvoiceStylesState {
  const InvoiceStylesInitial();
}

class InvoiceStylesLoading extends InvoiceStylesState {
  const InvoiceStylesLoading();
}

class InvoiceStylesLoaded extends InvoiceStylesState {
  final List<InvoiceStyles>? invoiceStyles;
  const InvoiceStylesLoaded(this.invoiceStyles);

  @override
  List<Object> get props => [invoiceStyles ?? ""];
}

class InvoiceStylesError extends InvoiceStylesState {
  final String message;
  const InvoiceStylesError(this.message);

  @override
  List<Object> get props => [message];
}
