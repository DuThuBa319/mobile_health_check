import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../common_widget/enum_common.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>(_onLogin);
  }
  Future<void> _onLogin(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginInitialState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    // final response = await _usecase.getListUserEntity();
    if (event.username == null || event.username?.trim() == '') {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Vui lòng nhập tài khoản',
          ),
        ),
      );
      return;
    }
    if (event.password == null || event.password?.trim() == '') {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Vui lòng nhập mật khẩu',
          ),
        ),
      );
      return;
    }
    final user =
        userList.where((element) => element.name == event.username).firstOrNull;
    if (user == null || event.password != '123') {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Tài khoản hoặc mật khẩu không đúng',
          ),
        ),
      );
      return;
    } else {
      emit(
        LoginSuccessState(
          status: BlocStatusState.success,
          viewModel: _ViewModel(isLogin: true, person: user),
        ),
      );
      return;
    }
  }
}

var userList = [
  User(name: 'PDA'),
];
