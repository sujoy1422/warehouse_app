import '../../models/login_object.dart';
import '../../service/web_service.dart';
import 'login_object_repo.dart';

class LoginObjectRepoImpl implements LoginObjectRepository {
  @override
  Future<LoginObject> fetchLoginObject(
      String empNo, String pass, orgId, empCat) {
    return WebService().getLoginData(empNo, pass, orgId, empCat);
  }
}
