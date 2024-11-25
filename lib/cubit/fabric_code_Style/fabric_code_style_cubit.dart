import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/fabric_code_style/fabric_code_style.dart';
import 'package:warehouse_app/repository/fabric_code_style_repository/fabric_code_style_repository.dart';

part 'fabric_code_style_state.dart';

class FabricCodeStyleCubit extends Cubit<FabricCodeStyleState> {
  FabricCodeStyleRepository _fabricCodeStyleRepository;
  FabricCodeStyleCubit(this._fabricCodeStyleRepository)
      : super(const FabricCodeStyleInitial());

  Future<void> getfabricCodetStyle(String headerid, String articleNo) async {
    try {
      emit(const FabricCodeStyleLoading());
      final inventoryData = await _fabricCodeStyleRepository.fetchInvoiceStatus(
          headerid, articleNo);
      emit(FabricCodeStyleLoaded(inventoryData));
    } on Exception {
      emit(const FabricCodeStyleError("Couldn't Fetch data!"));
    }
  }
}
