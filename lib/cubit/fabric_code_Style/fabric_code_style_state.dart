part of 'fabric_code_style_cubit.dart';

abstract class FabricCodeStyleState extends Equatable {
  const FabricCodeStyleState();

  @override
  List<Object> get props => [];
}

class FabricCodeStyleInitial extends FabricCodeStyleState {
  const FabricCodeStyleInitial();
}

class FabricCodeStyleLoading extends FabricCodeStyleState {
  const FabricCodeStyleLoading();
}

class FabricCodeStyleLoaded extends FabricCodeStyleState {
  final List<FabricCodeStyle> fabricCodeStyle;
  const FabricCodeStyleLoaded(this.fabricCodeStyle);
}

class FabricCodeStyleError extends FabricCodeStyleState {
  final String message;

  const FabricCodeStyleError(this.message);

  @override
  List<Object> get props => [message];
}
