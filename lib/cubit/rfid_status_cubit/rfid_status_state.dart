part of 'rfid_status_cubit.dart';

abstract class RfidStatusState extends Equatable {
  const RfidStatusState();

  @override
  List<Object> get props => [];
}

class RfidStatusInitial extends RfidStatusState {
  const RfidStatusInitial();
}

class RfidStatusLoading extends RfidStatusState {
  const RfidStatusLoading();
}

class RfidStatusLoaded extends RfidStatusState {
  final RfidStatus rfidStatus;
  const RfidStatusLoaded(this.rfidStatus);
  @override
  List<Object> get props => [rfidStatus ];
}

class RfidStatusError extends RfidStatusState {
  final String message;
  const RfidStatusError(this.message);

  @override
  List<Object> get props => [message];
}
