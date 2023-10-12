import 'package:warehouse_app/models/style_wise_roll.dart';
import 'package:warehouse_app/repository/style_wise_roll_repo/style_wise_roll_repository.dart';

import '../../service/web_service.dart';

class StyleWiseRollRepoImpl implements StyleWiseRollRepository {
  @override
  Future<List<StyleWiseRoll>> fetchStyleWiseRollList(String systemId) {
    return WebService().getStyleWiseRoll(systemId);
  }
}
