part of 'doctor_list_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorListScreenAction on _DoctorListState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
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
    if (state is RegistDoctorState && state.status == BlocStatusState.loading) {
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

    if (state is RegistDoctorState && state.status == BlocStatusState.success) {
      showNoticeDialog(
          onClose: () {
            Navigator.pushNamed(context, RouteList.doctorList,
                arguments: userDataData.getUser()?.id);
          },
          context: context,
          message: translation(context).addDoctorSuccessfully,
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
