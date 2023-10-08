part of 'roll_details_cubit.dart';

abstract class RollDetailsState extends Equatable {
  const RollDetailsState();

  @override
  List<Object> get props => [];
}

class RollDetailsInitial extends RollDetailsState {
  const RollDetailsInitial();
}

class RollDetailsLoading extends RollDetailsState {
  const RollDetailsLoading();
}

class RollDetailsLoaded extends RollDetailsState {
  final List<RollDetails> rollDetails;
  const RollDetailsLoaded(this.rollDetails);

  @override
  List<Object> get props => [rollDetails];
}

class RollDetailsError extends RollDetailsState {
  final String message;
  const RollDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
