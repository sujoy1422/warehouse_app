part of 'searchable_roll_list_cubit.dart';

abstract class SearchableRollListState extends Equatable {
  const SearchableRollListState();

  @override
  List<Object> get props => [];
}

class SearchableRollListInitial extends SearchableRollListState {
  const SearchableRollListInitial();
}

class SearchableRollListLoading extends SearchableRollListState {
  const SearchableRollListLoading();
}

class SearchableRollListLoaded extends SearchableRollListState {
  final List<SearchableRollList> searchableRollList;
  const SearchableRollListLoaded(this.searchableRollList);

  @override
  List<Object> get props => [searchableRollList];
}

class SearchableRollListError extends SearchableRollListState {
  final String message;
  const SearchableRollListError(this.message);

  @override
  List<Object> get props => [message];
}
