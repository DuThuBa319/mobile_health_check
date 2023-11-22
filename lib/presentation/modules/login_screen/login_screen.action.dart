// ignore_for_file: use_build_context_synchronously

part of 'login_screen.dart';

// ignore: library_private_types_in_public_api
extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    if (state is LoginInitialState && state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }

    if (state is LoginActionState && state.status == BlocStatusState.failure) {
      if ((state.viewModel.errorMessage ==
              translation(context).pleaseEnterYourAccount ||
          state.viewModel.errorMessage ==
              translation(context).pleaseEnterYourPassword)) {
        Navigator.pop(context);
      } else if (state.viewModel.errorMessage ==
          translation(context).wrongAccount) {
        showNoticeDialog(
            onClose: () => Navigator.pop(context),
            context: context,
            message: translation(context).wrongAccount,
            title: translation(context).notification,
            titleBtn: translation(context).exit);
      } else if (state.viewModel.errorMessage ==
          translation(context).wifiDisconnect) {
        showNoticeDialog(
            context: context,
            message: translation(context).wifiDisconnect,
            title: translation(context).notification,
            titleBtn: translation(context).exit);
      } else {
        showNoticeDialog(
            onClose: () => Navigator.pop(context),
            context: context,
            message: translation(context).error,
            title: translation(context).notification,
            titleBtn: translation(context).exit);
      }
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
      userDataData.setLogin();
      Navigator.pop(context);
      showToast(translation(context).verifySuccessfully);
      bloc.add(GetUserDataEvent(doctorId: userDataData.getUser()!.id!));
    }

    if (state is GetUserDataState && state.status == BlocStatusState.success) {
      Navigator.pop(context);

      if (userDataData.getUser()!.role == UserRole.admin) {
        Navigator.pushNamed(context, RouteList.doctorList,
            arguments: userDataData.getUser()!.id!);
      }

      if ((userDataData.getUser()!.role! == UserRole.doctor ||
          userDataData.getUser()!.role! == UserRole.relative)) {
        notificationData.saveDelayTime(0);
        Navigator.pushNamed(context, RouteList.patientList,
            arguments: userDataData.getUser()!.id!);
      }

      if (userDataData.getUser()!.role! == UserRole.patient) {
        Navigator.pushNamed(context, RouteList.selectEquip);
      }
    }

    if (state is GetUserDataState && state.status == BlocStatusState.failure) {
      Navigator.pop(context);
      showNoticeDialog(
          context: context,
          message: translation(context).error,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
      if (userDataData.getUser() != null) {
        userDataData.localDataManager.preferencesHelper.remove('user');
      }
    }
  }

  _onWillPop(bool didPop) async {
    bool enableToPop = true;

    if (enableToPop == true) {
      await showNoticeDialogTwoButton(
          context: context,
          message: translation(context).exitApp,
          title: translation(context).areYouSure,
          titleBtn1: translation(context).no,
          titleBtn2: translation(context).yes,
          onClose1: () {},
          onClose2: () {
            SystemNavigator.pop();
          });
    }
  }

  Future<void> login() async {
    final userName = _usernameController.text;
    final password = _passwordController.text;

    bloc.add(
      LoginUserEvent(
        username: userName,
        password: password,
      ),
    );
  }
}
