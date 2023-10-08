import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/searchable_roll_list.dart';
import 'package:warehouse_app/repository/searchable_roll_list_repo/searchable_roll_list_repository.dart';

part 'searchable_roll_list_state.dart';

class SearchableRollListCubit extends Cubit<SearchableRollListState> {
  final SearchableRollListRepository _searchableRollListRepository;

  SearchableRollListCubit(this._searchableRollListRepository)
      : super(const SearchableRollListInitial());

  Future<void> searchableRollList(
      ) async {
    try {
      emit(const SearchableRollListLoading());
      final responseData =
          await _searchableRollListRepository.fetchSearchableRollList();
      emit(SearchableRollListLoaded(responseData));
    } on Exception {
      emit(const SearchableRollListError("Couldn't Fetch roll!"));
    }
  }
}
