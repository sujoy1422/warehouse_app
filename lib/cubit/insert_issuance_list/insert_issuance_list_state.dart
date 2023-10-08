part of 'insert_issuance_list_cubit.dart';

abstract class InsertIssuanceListState extends Equatable {
  const InsertIssuanceListState();

  @override
  List<Object> get props => [];
}

class InsertIssuanceListInitial extends InsertIssuanceListState {
  const InsertIssuanceListInitial();
}

class InsertIssuanceListLoading extends InsertIssuanceListState {
  const InsertIssuanceListLoading();
}

class InsertIssuanceListLoaded extends InsertIssuanceListState {
  final ResponseObject responseObject;
  const InsertIssuanceListLoaded(this.responseObject);
}

class InsertIssuanceListError extends InsertIssuanceListState {
  final String message;

  const InsertIssuanceListError(this.message);

  @override
  List<Object> get props => [message];
}
