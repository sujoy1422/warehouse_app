import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/style_wise_count.dart';
import 'package:warehouse_app/repository/style_wise_count_repo/style_wise_count_repository.dart';

part 'style_wise_count_state.dart';

class StyleWiseCountCubit extends Cubit<StyleWiseCountState> {
  final StyleWiseCountRepository _styleWiseCountRepository;

  StyleWiseCountCubit(this._styleWiseCountRepository)
      : super(const StyleWiseCountInitial());

  Future<void> searchableCountList() async {
    try {
      emit(const StyleWiseCountLoading());
      final responseData =
          await _styleWiseCountRepository.fetchStyleWiseCountList();
      emit(StyleWiseCountLoaded(responseData));
    } on Exception {
      emit(const StyleWiseCountError("Couldn't Fetch roll!"));
    }
  }
}
