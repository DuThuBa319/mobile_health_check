part of 'blood_pressure_reading_screen.dart';

// ignore: library_private_types_in_public_api
extension BloodPressureReadingScreenAction on _BloodPressureReadingScreenState {
  void blocListener(BuildContext context, OCRScannerState state) async {
    if (state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state.status == BlocStatusState.success) {
      if (state is UploadBloodPressureDataState) {
        showSuccessDialog(
            context: context,
            message: translation(context).uploadBloodPressureSuccessfully,
            title: translation(context).uploadSuccessfully,
            titleBtn: translation(context).exit,
            onClose: (){  Navigator.pushNamedAndRemoveUntil(
            context, RouteList.selectEquip, (Route<dynamic> route) => false);}
            );
      }
      showToast(translation(context).dataLoaded);
    }
    if (state.status == BlocStatusState.failure) {
      showExceptionDialog(
          context: context,
          message: translation(context).error,
          titleBtn: translation(context).exit,
          onClose: () {});
    }
  }
}
