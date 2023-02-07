part of 'update_rfid_cubit.dart';

abstract class UpdateRfidState extends Equatable {
  const UpdateRfidState();

  @override
  List<Object> get props => [];
}

class UpdateRfidInitial extends UpdateRfidState {
  const UpdateRfidInitial();
}

class UpdateRfidLoading extends UpdateRfidState {
  const UpdateRfidLoading();
}

class UpdateRfidLoaded extends UpdateRfidState {
  final ResponseObject response;
  const UpdateRfidLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class UpdateRfidError extends UpdateRfidState {
  final String message;
  const UpdateRfidError(this.message);

  @override
  List<Object> get props => [message];
}
