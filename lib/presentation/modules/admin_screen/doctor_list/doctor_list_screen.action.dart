part of 'doctor_list_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorListScreenAction on _DoctorListState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    if (state is GetDoctorListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if ((state is GetDoctorListState &&
        state.status == BlocStatusState.success)) {
      showToast(translation(context).dataLoaded);
    }
    if (state is GetDoctorListState &&
        state.status == BlocStatusState.failure) {
      showToast(translation(context).loadingError);
    }
  if (state is DeleteDoctorState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).deleteDoctorSuccessfully);
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
  Future<bool> _onWillPop() async {
    return (await showNoticeDialogTwoButton(
            context: context,
            message: translation(context).exitApp,
            title: translation(context).areYouSure,
            titleBtn1: translation(context).no,
            titleBtn2: translation(context).yes,
            onClose1: () {},
            onClose2: () {
              Navigator.pop(context);
            })) ??
        false;
  }
}
