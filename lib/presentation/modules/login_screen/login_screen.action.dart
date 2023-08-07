part of 'login_screen.dart';

extension LoginAction on _LoginState {
  void _blocListener(BuildContext context, LoginState state) {
    if (state is LoginInitialState && state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }

    if (state is LoginSuccessState) {
       Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } else if (state is LoginFailState) {
      final message = state.viewModel.errorMessage ?? '--';

      showNoticeDialog(context: context, message: message);
    }
  }

  Future<void> login() async {
    final userName = _accountCtroller.text;
    final password = _passCtroller.text;
    bloc.add(
      LoginUserEvent(
        username: userName,
        password: password,
      ),
    );
  }
}
