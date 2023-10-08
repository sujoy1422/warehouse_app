
import '../../models/searchable_roll_list.dart';
import '../../service/web_service.dart';
import 'searchable_roll_list_repository.dart';

class SearchableRollListRepoImpl implements SearchableRollListRepository {
  @override
  Future<List<SearchableRollList>> fetchSearchableRollList() {
    // TODO: implement fetchSearchableRollList
    return WebService().getSearchableRollList();
  }
}
