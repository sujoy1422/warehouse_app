part of 'rfid_for_inspection_cubit.dart';

abstract class RfidForInspectionState extends Equatable {
  const RfidForInspectionState();

  @override
  List<Object> get props => [];
}

class RfidForInspectionInitial extends RfidForInspectionState {
  const RfidForInspectionInitial();
}
class RfidForInspectionLoading extends RfidForInspectionState {
  const RfidForInspectionLoading();
}
class RfidForInspectionLoaded extends RfidForInspectionState {
    final RfidForInspection rfidForInspection ;
  const RfidForInspectionLoaded(this.rfidForInspection);

  @override
  List<Object> get props => [rfidForInspection];
}
class RfidForInspectionError extends RfidForInspectionState {
  final String message;
  const RfidForInspectionError(this.message);

  @override
  List<Object> get props => [message];
}
