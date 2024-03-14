// ignore_for_file: use_build_context_synchronously

part of 'login_screen.dart';

// ignore: library_private_types_in_public_api
extension LoginAction on _LoginState {
  Future<void> _blocListener(BuildContext context, LoginState state) async {
    //? LOADING

    if (state.status == BlocStatusState.loading) {
      if (state is LoginInitialState) {
        showToast(
            context: context,
            status: ToastStatus.loading,
            toastString: translation(context).loadingData);
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
                SizedBox(
                  height: SizeConfig.screenDiagonal * 0.04,
                  width: SizeConfig.screenDiagonal * 0.04,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: SizeConfig.screenWidth * 0.01,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Text(translation(context).verifying,
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: SizeConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w500)),
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
                SizedBox(
                  height: SizeConfig.screenDiagonal * 0.04,
                  width: SizeConfig.screenDiagonal * 0.04,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: SizeConfig.screenWidth * 0.01,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Text("${translation(context).loadingData}...",
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: SizeConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        );
      }
    }
    //? SUCCESS
    if (state.status == BlocStatusState.success) {
      if (state is LoginActionState) {
        userDataData.setLogin();
        Navigator.pop(context);
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).verifySuccessfully);
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

    //? FAILURE
    if (state.status == BlocStatusState.failure) {
      if (state is LoginActionState) {
        //! Lỗi do LoginAction => ko cần Navigator.Pop trước hoặc sau hiện Dialog
        if (state.viewModel.errorMessage ==
            translation(context).pleaseEnterYourAccount) {
          Navigator.pop(context);
        } else if (state.viewModel.isWrongAccount == true) {
          showExceptionDialog(
              contentDialogSize: SizeConfig.screenDiagonal < 1350
                  ? SizeConfig.screenWidth * 0.045
                  : SizeConfig.screenWidth * 0.04,
              onClose: () => Navigator.pop(context),
              context: context,
              message: translation(context).wrongAccount,
              titleBtn: translation(context).exit);
        } else if (state.viewModel.isWifiDisconnect == true) {
          showToast(
            context: context,
            status: ToastStatus.error,
            toastString: state.viewModel.errorMessage!,
          );
        } else if (state.viewModel.errorMessage == translation(context).error) {
          showToast(
            context: context,
            status: ToastStatus.error,
            toastString: state.viewModel.errorMessage!,
          );
        }
      } else if (state is GetUserDataState) {
        if (state.viewModel.errorMessage == translation(context).error) {
          Navigator.pop(context);
          showToast(
            context: context,
            status: ToastStatus.error,
            toastString: state.viewModel.errorMessage!,
          );
          if (userDataData.getUser() != null) {
            userDataData.localDataManager.preferencesHelper.remove('user');
          }
        } else if (state.viewModel.isWifiDisconnect == true) {
          Navigator.pop(context);
          showToast(
            context: context,
            status: ToastStatus.error,
            toastString: state.viewModel.errorMessage!,
          );
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
