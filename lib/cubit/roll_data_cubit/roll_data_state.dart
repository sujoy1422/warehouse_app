part of 'roll_data_cubit.dart';

abstract class RollDataState extends Equatable {
  const RollDataState();

  @override
  List<Object> get props => [];
}

class RollDataInitial extends RollDataState {
  const RollDataInitial();
}

class RollDataLoading extends RollDataState {
  const RollDataLoading();
}

class RollDataLoaded extends RollDataState {
  final List<RollData> rolldata;
  const RollDataLoaded(this.rolldata);

  @override
  List<Object> get props => [rolldata];
}

class RollDataError extends RollDataState {
  final String message;
  const RollDataError(this.message);

  @override
  List<Object> get props => [message];
}
