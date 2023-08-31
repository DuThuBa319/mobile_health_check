part of 'login_screen.dart';

extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    if (state is LoginInitialState && state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }

    if (state is LoginSuccessState) {
      await OneSignalNotificationService.create();
      OneSignalNotificationService.subscribeNotification(
          doctorId: userDataData.getUser()!.id!);
          
      Navigator.pushNamed(context, RouteList.patientList);
      //get unread notification count,userInfo
    } else if (state is LoginFailState) {
      final message = state.viewModel.errorMessage ?? '--';

      showNoticeDialog(context: context, message: message);
    }
    // if(state is Get&& ){
    //    //! get list Notification => length unread
    //   bloc.add(GetUnreadCountEvent());
    //   notificationData.saveUnreadNotificationCount(state.viewModel.count);
    //   //notificationData.saveUnreadNotificationCount(0);
    //   //! truyền Id cho trang này
    //   Navigator.pushNamed(context, RouteList.patientList);
    // }
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
