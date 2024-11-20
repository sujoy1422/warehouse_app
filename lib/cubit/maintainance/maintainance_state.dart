part of 'maintainance_cubit.dart';

abstract class MaintainanceState extends Equatable {
  const MaintainanceState();

  @override
  List<Object> get props => [];
}

class MaintainanceInitial extends MaintainanceState {
  const MaintainanceInitial();
}

class MaintainanceLoading extends MaintainanceState {
  const MaintainanceLoading();
}
class MaintainanceLoaded extends MaintainanceState {
    final MaintainanceResponse? maintainanceResponse;
  const MaintainanceLoaded(this.maintainanceResponse);
    @override
  List<Object> get props => [maintainanceResponse??""];

}
class MaintainanceError extends MaintainanceState {
  final String message;
  const MaintainanceError(this.message);

  @override
  List<Object> get props => [message];
}
