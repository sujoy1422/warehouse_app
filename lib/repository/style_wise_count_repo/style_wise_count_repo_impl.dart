import 'package:warehouse_app/models/style_wise_count.dart';
import 'package:warehouse_app/repository/style_wise_count_repo/style_wise_count_repository.dart';

import '../../service/web_service.dart';

class StyleWiseCountRepoImpl implements StyleWiseCountRepository {
  @override
  Future<List<StyleWiseCount>> fetchStyleWiseCountList() {
    return WebService().getStyleWiseCount();
  }
}
