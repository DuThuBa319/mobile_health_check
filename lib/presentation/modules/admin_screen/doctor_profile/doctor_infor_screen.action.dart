part of 'doctor_infor_screen.dart';

// ignore: library_private_types_in_public_api
extension DoctorInforScreenAction on _DoctorInforScreenState {
  void _blocListener(BuildContext context, GetDoctorState state) {
    //? Loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetDoctorInforState) {
        showToast(translation(context).loadingData);
      }
    }
    //? Success
    if (state.status == BlocStatusState.success) {
      if (state is GetDoctorInforState) {
        showToast(translation(context).dataLoaded);
      }
    }
    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(translation(context).error);
      showExceptionDialog(
          context: context,
          message: state.viewModel.errorMessage!,
          titleBtn: translation(context).exit);
    }
  }
}
