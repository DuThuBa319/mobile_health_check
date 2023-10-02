part of 'patients_list_screen.dart';

extension PatientListScreenAction on _PatientListState {
  void _blocListener(BuildContext context, GetPatientState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetPatientListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if ((state is GetPatientListState &&
            state.status == BlocStatusState.success) ||
        (state is GetPatientListOfRelativeState &&
            state.status == BlocStatusState.success)) {
      // ignore: invalid_use_of_protected_member
     

      showToast(translation(context).dataLoaded);
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
    }
    if (state is RegistPatientState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).waitForSeconds);
    }
    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                translation(context).notification,
                style: TextStyle(
                    color: AppColor.lineDecor,
                    fontSize: SizeConfig.screenWidth * 0.08,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                translation(context).wifiDisconnect,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                TextButton(
                  child: Text(translation(context).accept),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    if (state is RegistPatientState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          context: context,
          message: 'Đăng ký thành công',
          title: translation(context).notification,
          titleBtn: translation(context).exit);
    }
  }

  void gotoRegistPatientScreen() {
    Navigator.pushNamed(context, RouteList.registPatient,
        arguments: patientBloc);
  }

  Future<bool> _onWillPop() async {
    return (await showNoticeDialogTwoButton(
            context: context,
            message: 'Do you want to exit an App',
            title: 'Are you sure?',
            titleBtn1: 'No',
            titleBtn2: 'Yes',
            onClose1: () {},
            onClose2: () {
              SystemNavigator.pop();
            })) ??
        false;
  }
}
