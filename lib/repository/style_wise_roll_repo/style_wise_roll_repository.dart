import 'package:warehouse_app/models/style_wise_roll.dart';



abstract class StyleWiseRollRepository {
  Future<List<StyleWiseRoll>> fetchStyleWiseRollList(String systemId);
}
