import '../../models/profile.dart';

abstract class ProfileObjectRepository {
  Future<Profile> fetchProfileData(String? empNo);
}
