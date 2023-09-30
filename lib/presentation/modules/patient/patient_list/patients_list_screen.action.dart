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
      setState(() {
        numberOfNotification =
            state.viewModel.numberOfNotificationsEntity!.numberOfNotifications!;
      });

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
              content: SizedBox(
                height: SizeConfig.screenHeight * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${translation(context).addPatientSuccessfully}!",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: SizeConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: SizeConfig.screenWidth * 0.05),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${translation(context).account}: ',
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: state.viewModel.userName ?? "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.05),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${translation(context).password}: ',
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: state.viewModel.password ?? "--",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.05),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(translation(context).accept),
                  onPressed: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, RouteList.patientList,
                        arguments: userDataData.getUser()!.id);
                  },
                ),
              ],
            );
          });
    }
  }

  void gotoRegistPatientScreen() {
    Navigator.pushNamed(context, RouteList.registPatient,
        arguments: patientBloc);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
