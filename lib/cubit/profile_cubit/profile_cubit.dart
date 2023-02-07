import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/profile.dart';
import '../../repository/profile/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileCubitState> {
  final ProfileObjectRepository _profileObjectRepository;

  ProfileCubit(this._profileObjectRepository)
      : super(const ProfileCubitInitial());

  Future<void> getProfileData(String? empNo) async {
    try {
      emit(const ProfileCubitLoading());
      final profileObject =
          await _profileObjectRepository.fetchProfileData(empNo);
      emit(ProfileCubitLoaded(profileObject));
    } on Exception {
      emit(const ProfileCubitError("Couldn't load profile!"));
    }
  }
}
