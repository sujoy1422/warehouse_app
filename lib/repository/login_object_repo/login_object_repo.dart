import '../../models/login_object.dart';

abstract class LoginObjectRepository {
  Future<LoginObject> fetchLoginObject(
      String empNo, String pass, orgId, empCat);
}
