import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/rfid_status/rfid_status.dart';
import '../../repository/rfid_status_repo/rfid_status_repo.dart';

part 'rfid_status_state.dart';

class RfidStatusCubit extends Cubit<RfidStatusState> {
  final RfidStatusRepository _rfidStatusRepository;

  RfidStatusCubit(this._rfidStatusRepository)
      : super(const RfidStatusInitial());

  Future<void> getStatusData(String rfidNo) async { 
    try {
      emit(const RfidStatusLoading());
      final statusData = await _rfidStatusRepository.fetchRfidStatus(rfidNo);
      emit(RfidStatusLoaded(statusData));
    } on Exception {
      emit(const RfidStatusError("Couldn't Fetch Status data!"));
    }
  }
}
