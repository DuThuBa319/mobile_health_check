// ignore_for_file: use_build_context_synchronously

part of 'login_screen.dart';

extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    if (state is LoginInitialState && state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is LoginActionState && state.status == BlocStatusState.loading) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 10,
              ),
              Material(
                type: MaterialType.transparency,
                child: Text(
                  translation(context).verifying,
                  style: AppTextTheme.body3.copyWith(
                    color: Colors.white,
                    decoration: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (state is GetUserDataState && state.status == BlocStatusState.loading) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 10,
              ),
              Material(
                type: MaterialType.transparency,
                child: Text(
                  "${translation(context).loadingData}...",
                  style: AppTextTheme.body3.copyWith(
                    color: Colors.white,
                    decoration: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is LoginActionState && state.status == BlocStatusState.success) {
      Navigator.pop(context);
      showToast(translation(context).verifySuccessfully);
      bloc.add(GetUserDataEvent(doctorId: userDataData.getUser()!.id!));
      // bloc.add(GetUnreadCountNotificationEvent(
      //     doctorId: userDataData.getUser()!.id!));
    }

    if (state is GetUserDataState && state.status == BlocStatusState.success) {
      Navigator.pop(context);
      if (userDataData.getUser()!.role! == 'doctor') {
        Navigator.pushNamed(context, RouteList.patientList,
            arguments: userDataData.getUser()!.id!);
      }

      if (userDataData.getUser()!.role! == 'patient') {
        Navigator.pushNamed(context, RouteList.selectEquip);
      }
    }

    if (state.status == BlocStatusState.failure) {
      final message = state.viewModel.errorMessage ?? '--';
      Navigator.pop(context);
      showNoticeDialog(context: context, message: message);
      if (userDataData.getUser() != null) {
        userDataData.localDataManager.preferencesHelper.remove('user');
      }
    }
  }

  Future<void> login() async {
    final userName = _usernameController.text;
    final password = _passwordController.text;
    // await firebaseAuthService.createUserWithEmailAndPassword(
    //     email: userName, password: password);
    bloc.add(
      LoginUserEvent(
        username: userName,
        password: password,
      ),
    );
  }
}
