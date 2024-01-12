// ignore_for_file: use_build_context_synchronously

part of 'login_screen.dart';

// ignore: library_private_types_in_public_api
extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    if (state.status == BlocStatusState.loading) {
      if (state is LoginInitialState) {
        showToast(translation(context).loadingData);
      }
      if (state is LoginActionState) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColor.white),
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
      if (state is GetUserDataState) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColor.white),
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
    }
    if (state.status == BlocStatusState.failure) {
      if (state is GetUserDataState) {
        Navigator.pop(context);
        showExceptionDialog(
            context: context,
            message: translation(context).error,
            titleBtn: translation(context).exit);
        if (userDataData.getUser() != null) {
          userDataData.localDataManager.preferencesHelper.remove('user');
        }
      }
      if (state is LoginActionState) {
        if (state.viewModel.errorMessage ==
            translation(context).pleaseEnterYourAccount) {
          Navigator.pop(context);
        } else if (state.viewModel.errorMessage ==
            translation(context).wrongAccount) {
          showExceptionDialog(
              onClose: () => Navigator.pop(context),
              context: context,
              message: translation(context).wrongAccount,
              titleBtn: translation(context).exit);
        } else if (state.viewModel.errorMessage ==
            translation(context).wifiDisconnect) {
          showExceptionDialog(
              context: context,
              message: translation(context).wifiDisconnect,
              titleBtn: translation(context).exit);
        } else {
          showExceptionDialog(
              onClose: () => Navigator.pop(context),
              context: context,
              message: translation(context).error,
              titleBtn: translation(context).exit);
        }
      }
    }
    if (state.status == BlocStatusState.success) {
      if (state is LoginActionState) {
        userDataData.setLogin();
        Navigator.pop(context);
        showToast(translation(context).verifySuccessfully);
        bloc.add(GetUserDataEvent(doctorId: userDataData.getUser()!.id!));
      }
      if (state is GetUserDataState) {
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
    }
  }

  _onWillPop(bool didPop) async {
    bool enableToPop = true;
    if (enableToPop == true) {
      await showWarningDialog(
          context: context,
          message: translation(context).areYouSureToExitApp,
          title: translation(context).exitAppTitle,
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
