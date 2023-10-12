import 'package:warehouse_app/models/style_wise_count.dart';



abstract class StyleWiseCountRepository {
  Future<List<StyleWiseCount>> fetchStyleWiseCountList();
}
