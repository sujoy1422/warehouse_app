import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/style_wise_roll.dart';
import 'package:warehouse_app/repository/style_wise_roll_repo/style_wise_roll_repository.dart';

part 'style_wise_roll_state.dart';

class StyleWiseRollCubit extends Cubit<StyleWiseRollState> {
  final StyleWiseRollRepository _styleWiseRollRepository;

  StyleWiseRollCubit(this._styleWiseRollRepository)
      : super(const StyleWiseRollInitial());

  Future<void> searchableRollList(String systemId) async {
    try {
      emit(const StyleWiseRollLoading());
      final responseData =
          await _styleWiseRollRepository.fetchStyleWiseRollList(systemId);
      emit(StyleWiseRollLoaded(responseData));
    } on Exception {
      emit(const StyleWiseRollError("Couldn't Fetch roll!"));
    }
  }
}
