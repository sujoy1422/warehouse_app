part of 'rfid_name_cubit.dart';

abstract class RfidNameState extends Equatable {
  const RfidNameState();

  @override
  List<Object> get props => [];
}

class RfidNameInitial extends RfidNameState {
  const RfidNameInitial();
}

class RfidNameLoading extends RfidNameState {
  const RfidNameLoading();
}

class RfidNameLoaded extends RfidNameState {
  final RfidName rfidName;
  const RfidNameLoaded(this.rfidName);
  @override
  List<Object> get props => [rfidName ];
}

class RfidNameError extends RfidNameState {
  final String message;
  const RfidNameError(this.message);

  @override
  List<Object> get props => [message];
}
