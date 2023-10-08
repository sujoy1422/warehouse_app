import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/rfid_name.dart';
import '../../repository/rfid_name_repo/rfid_name_repository.dart';

part 'rfid_name_state.dart';

class RfidNameCubit extends Cubit<RfidNameState> {
  final RfidNameRepository _rfidNameRepository;

  RfidNameCubit(this._rfidNameRepository)
      : super(const RfidNameInitial());

  Future<void> getNameData(String rfidNo) async { 
    try {
      emit(const RfidNameLoading());
      final statusData = await _rfidNameRepository.fetchRfidName(rfidNo);
      emit(RfidNameLoaded(statusData));
    } on Exception {
      emit(const RfidNameError("Couldn't Fetch Name data!"));
    }
  }
}
