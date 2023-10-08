import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/roll_details.dart';
import 'package:warehouse_app/repository/roll_details_repository/roll_details_repository.dart';

part 'roll_details_state.dart';

class RollDetailsCubit extends Cubit<RollDetailsState> {
    final RollDetailsRepository _rollDetailsRepository;

  

  RollDetailsCubit(this._rollDetailsRepository) : super(const RollDetailsInitial());

  Future<void> getRollDetails(String rfidNo) async {
    try {
      emit(const RollDetailsLoading());
      final rollData = await _rollDetailsRepository.fetchRollDetails(rfidNo);
      emit(RollDetailsLoaded(rollData));
    } on Exception {
      emit(const RollDetailsError("Couldn't Fetch roll details!"));
    }
  }
}
