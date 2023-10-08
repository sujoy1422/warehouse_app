import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/pallet_info/pallet_info.dart';
import '../../repository/pallet_info_repo/pallet_info_repository.dart';

part 'pallet_info_state.dart';

class PalletInfoCubit extends Cubit<PalletInfoState> {
  final PalletInfoRepository _rfidNameRepository;

  PalletInfoCubit(this._rfidNameRepository)
      : super(const PalletInfoInitial());

  Future<void> getPalletInfo(String palletId) async { 
    try {
      emit(const PalletInfoLoading());
      final statusData = await _rfidNameRepository.fetchPalletInfo(palletId);
      emit(PalletInfoLoaded(statusData));
    } on Exception {
      emit(const PalletInfoError("Couldn't Fetch pallet info!"));
    }
  }
}
