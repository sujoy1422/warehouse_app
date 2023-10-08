import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/inspection_list/inspection_list.dart';

import '../../repository/inspection_list_repo/inspection_list_repository.dart';

part 'inspection_list_state.dart';

class InspectionListCubit extends Cubit<InspectionListState> {
  InspectionListRepository _inspectionListRepository;
  InspectionListCubit(this._inspectionListRepository)
      : super(const InspectionListInitial());

  Future<void> getInspectionData(String empNo) async {
    try {
      emit(const InspectionListLoading());
      final inventoryData =
          await _inspectionListRepository.fetchInspectionList(empNo);
      emit(InspectionListLoaded(inventoryData));
    } on Exception {
      emit(const InspectionListError("Couldn't Fetch data!"));
    }
  }
}
