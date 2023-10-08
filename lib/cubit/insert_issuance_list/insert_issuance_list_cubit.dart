import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/cubit/inspection_list/inspection_list_cubit.dart';
import 'package:warehouse_app/models/response_object.dart';
import 'package:warehouse_app/repository/insert_inspection_repo/insert_inspection_repository.dart';

part 'insert_issuance_list_state.dart';

class InsertIssuanceListCubit extends Cubit<InsertIssuanceListState> {
  InsertInspectionRepository _insertInspectionRepository;
  InsertIssuanceListCubit(this._insertInspectionRepository)
      : super(const InsertIssuanceListInitial());

  Future<void> getInspectionData(String rfdiNo, String empNo) async {
    try {
      emit(const InsertIssuanceListLoading());
      final inventoryData =
          await _insertInspectionRepository.fetchReponse(rfdiNo, empNo);
      emit(InsertIssuanceListLoaded(inventoryData));
    } on Exception {
      emit(const InsertIssuanceListError("Couldn't Fetch data!"));
    }
  }
}
