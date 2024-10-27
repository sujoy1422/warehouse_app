import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/repository/update_rfid/update_rfid_repository.dart';

part 'update_rfid_state.dart';

class UpdateRfidCubit extends Cubit<UpdateRfidState> {
  final UpdateDataRepository _updateDataRepository;

  UpdateRfidCubit(this._updateDataRepository)
      : super(const UpdateRfidInitial());

  Future<void> updateRfid(
      String detailsId, String rfid, String entryBy, String entryType) async {
    try {
      emit(const UpdateRfidLoading());
      final responseData = await _updateDataRepository.fetchResponse(
          detailsId, rfid, entryBy, entryType);
      emit(UpdateRfidLoaded(responseData));
    } on Exception {
      emit(const UpdateRfidError("Couldn't Fetch roll!"));
    }
  }
}
