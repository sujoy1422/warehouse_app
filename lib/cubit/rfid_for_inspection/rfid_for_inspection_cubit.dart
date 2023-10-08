import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/rfid_for_inspection/rfid_for_inspection.dart';
import 'package:warehouse_app/repository/rfid_for_inspection_repo/rfid_for_inspection_repository.dart';

part 'rfid_for_inspection_state.dart';

class RfidForInspectionCubit extends Cubit<RfidForInspectionState> {
  RfidForInspectionRepository _rfidForInspectionRepository;

  RfidForInspectionCubit(this._rfidForInspectionRepository)
      : super(const RfidForInspectionInitial());

  Future<void> getRfidForInspectionData(String rfidNo, String empNo) async {
    try {
      emit(const RfidForInspectionLoading());
      final statusData = await _rfidForInspectionRepository.fetchInspectionList(rfidNo, empNo);
      emit(RfidForInspectionLoaded(statusData));
    } on Exception {
      emit(const RfidForInspectionError("Couldn't Fetch inspection data!"));
    }
  }
}
