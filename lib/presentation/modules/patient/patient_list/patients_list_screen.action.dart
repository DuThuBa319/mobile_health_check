part of 'patients_list_screen.dart';

extension PatientListScreenAction on _PatientListState {
  void _blocListener(BuildContext context, GetPatientState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetPatientListState &&
        state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.success) {
      showToast('Tải dữ liệu thành công');
    }
    if (state is RegistPatientState &&
        state.status == BlocStatusState.success) {
      showToast('Regist Patient successfully');
      Navigator.pop(context);
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
