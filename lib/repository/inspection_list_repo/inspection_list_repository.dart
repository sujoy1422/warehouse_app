import 'package:warehouse_app/models/inspection_list/inspection_list.dart';

abstract class InspectionListRepository {
  Future<List<InspectionList>> fetchInspectionList(String empNo);
}
