import '../../models/profile.dart';
import '../../service/web_service.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileObjectRepository {
  @override
  Future<Profile> fetchProfileData(String? empNo) {
    return WebService().getProfileData(empNo);
  }
}
