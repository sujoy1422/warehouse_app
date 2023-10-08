import '../../models/searchable_roll_list.dart';


abstract class SearchableRollListRepository {
  Future<List<SearchableRollList>> fetchSearchableRollList();
}
