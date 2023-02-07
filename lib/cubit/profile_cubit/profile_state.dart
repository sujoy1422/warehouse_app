part of 'profile_cubit.dart';

abstract class ProfileCubitState extends Equatable {
  const ProfileCubitState();

  @override
  List<Object> get props => [];
}

class ProfileCubitInitial extends ProfileCubitState {
  const ProfileCubitInitial();
}

class ProfileCubitLoading extends ProfileCubitState {
  const ProfileCubitLoading();
}

class ProfileCubitLoaded extends ProfileCubitState {
  final Profile? profile;
  const ProfileCubitLoaded(this.profile);

  @override
  List<Object> get props => [profile ?? []];
}

class ProfileCubitError extends ProfileCubitState {
  final String message;
  const ProfileCubitError(this.message);

  @override
  List<Object> get props => [message];
}
