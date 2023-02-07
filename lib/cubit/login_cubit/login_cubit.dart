import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/login_object.dart';
import '../../repository/login_object_repo/login_object_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginObjectRepository _loginObjectRepository;

  LoginCubit(this._loginObjectRepository) : super(const LoginInitial());

  Future<void> getLoginData(String empNo, String pass, orgId, empCat) async {
    try {
      emit(const LoginLoading());
      final loginObject = await _loginObjectRepository.fetchLoginObject(
          empNo, pass, orgId, empCat);
      emit(LoginSuccess(loginObject));
    } on Exception {
      emit(const LoginError("Couldn't authenticate data!"));
    }
  }
}
