part of 'style_wise_roll_cubit.dart';

abstract class StyleWiseRollState extends Equatable {
  const StyleWiseRollState();

  @override
  List<Object> get props => [];
}

class StyleWiseRollInitial extends StyleWiseRollState {
  const StyleWiseRollInitial();
}
class StyleWiseRollLoading extends StyleWiseRollState {
  const StyleWiseRollLoading();
}
class StyleWiseRollLoaded extends StyleWiseRollState {
  final List<StyleWiseRoll> styleWiseRoll;
  const StyleWiseRollLoaded(this.styleWiseRoll);

  @override
  List<Object> get props => [styleWiseRoll];
}
class StyleWiseRollError extends StyleWiseRollState {
  final String message;
  const StyleWiseRollError(this.message);

  @override
  List<Object> get props => [message];
}
