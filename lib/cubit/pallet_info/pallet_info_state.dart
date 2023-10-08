part of 'pallet_info_cubit.dart';

abstract class PalletInfoState extends Equatable {
  const PalletInfoState();

  @override
  List<Object> get props => [];
}

class PalletInfoInitial extends PalletInfoState {
  const PalletInfoInitial();
}


class PalletInfoLoading extends PalletInfoState {
  const PalletInfoLoading();
}

class PalletInfoLoaded extends PalletInfoState {
  final PalletInfo palletInfo;
  const PalletInfoLoaded(this.palletInfo);
  @override
  List<Object> get props => [palletInfo ];
}

class PalletInfoError extends PalletInfoState {
  final String message;
  const PalletInfoError(this.message);

  @override
  List<Object> get props => [message];
}