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
    if (state is GetPatientListState &&
        state.status == BlocStatusState.success) {
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
