part of 'patients_list_screen.dart';

extension PatientListScreenAction on _PatientListState {
  void _blocListener(BuildContext context, GetPatientState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetPatientListState &&
        state.status == BlocStatusState.loading) {
      showToast('Loading');
    }
    if (state is GetPatientListState &&
        state.status == BlocStatusState.success) {
      showToast('Loaded');
    }
    if (state is RegistPatientState &&
        state.status == BlocStatusState.success) {
      showToast('Regist Patient successfully');
      patientBloc.add(GetPatientListEvent());
      Navigator.pop(context);
    }
  }

  void gotoRegistPatientScreen() {
    Navigator.pushNamed(context, RouteList.registPatient,
        arguments: patientBloc);
  }
}
