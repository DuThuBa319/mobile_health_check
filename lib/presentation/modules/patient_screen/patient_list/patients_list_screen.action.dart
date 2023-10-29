part of 'patients_list_screen.dart';

// ignore: library_private_types_in_public_api
extension PatientListScreenAction on _PatientListState {
  void _blocListener(BuildContext context, GetPatientState state) {
    if (state is GetPatientListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is GetPatientListState &&
            state.status == BlocStatusState.success
            // ||
        // (state is GetPatientListOfRelativeState &&
        //     state.status == BlocStatusState.success)
            ) 
            {
      showToast(translation(context).dataLoaded);
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
    }
    if ((state is DeletePatientState &&
        state.status == BlocStatusState.success)) {
      patientBloc.add(GetPatientListEvent(userId: widget.id));
    }
    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          context: context,
          message: translation(context).wifiDisconnect,
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
            message: translation(context).exitApp,
            title: translation(context).areYouSure,
            titleBtn1: translation(context).no,
            titleBtn2: translation(context).yes,
            onClose1: () {},
            onClose2: () {
              SystemNavigator.pop();
            })) ??
        false;
  }
}
