part of 'style_wise_count_cubit.dart';

abstract class StyleWiseCountState extends Equatable {
  const StyleWiseCountState();

  @override
  List<Object> get props => [];
}
class StyleWiseCountInitial extends StyleWiseCountState {
  const StyleWiseCountInitial();
}
class StyleWiseCountLoading extends StyleWiseCountState {
  const StyleWiseCountLoading();
}
class StyleWiseCountLoaded extends StyleWiseCountState {
  final List<StyleWiseCount> styleWiseCount;
  const StyleWiseCountLoaded(this.styleWiseCount);

  @override
  List<Object> get props => [styleWiseCount];
}
class StyleWiseCountError extends StyleWiseCountState {
  final String message;
  const StyleWiseCountError(this.message);

  @override
  List<Object> get props => [message];
}
