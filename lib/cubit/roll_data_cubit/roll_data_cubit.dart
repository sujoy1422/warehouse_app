import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/roll_data.dart';
import 'package:warehouse_app/repository/roll_data_repository/roll_data_repository.dart';

part 'roll_data_state.dart';

class RollDataCubit extends Cubit<RollDataState> {
  final RollDataRepository _rollDataRepository;

  RollDataCubit(this._rollDataRepository) : super(const RollDataInitial());

  Future<void> getRollData(String headerId,String articleNo, String lineId, String showAll) async {
    try {
      emit(const RollDataLoading());
      final rollData = await _rollDataRepository.fetchRollData(headerId, articleNo, lineId, showAll);
      emit(RollDataLoaded(rollData));
    } on Exception {
      emit(const RollDataError("Couldn't Fetch roll!"));
    }
  }
}
