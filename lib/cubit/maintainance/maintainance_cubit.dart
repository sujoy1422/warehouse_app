import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/maintainance.dart';
import 'package:warehouse_app/repository/maintainance_repo/maintainance_repository.dart';

part 'maintainance_state.dart';

class MaintainanceCubit extends Cubit<MaintainanceState> {
  final MaintainanceRepository _maintainanceRepository;

  MaintainanceCubit(this._maintainanceRepository)
      : super(const MaintainanceInitial());

  Future<void> getMaintainance() async {
    try {
      emit(const MaintainanceLoading());
      final invoiceStatus =
          await _maintainanceRepository.fetchMaintainanceResponse();
      emit(MaintainanceLoaded(invoiceStatus));
    } on Exception {
      emit(const MaintainanceError("Couldn't Fetch data!"));
    }
  }
}
