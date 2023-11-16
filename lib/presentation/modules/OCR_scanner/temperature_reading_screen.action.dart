part of 'temperature_reading_screen.dart';

// ignore: library_private_types_in_public_api
extension TemperatureReadingScreenAction on _TemperatureReadingScreenState {
  void blocListener(BuildContext context, OCRScannerState state) async {
    if (state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state.status == BlocStatusState.success) {
      if (state is UploadTemperatureDataState) {
        successAlert(
          context,
          alertText: translation(context).uploadSuccessfully,
        );
      }
      showToast(translation(context).dataLoaded);
    }
    if (state.status == BlocStatusState.failure) {
      showNoticeDialog(
          context: context,
          message: translation(context).error,
          title: translation(context).notification,
          titleBtn: translation(context).exit,
          onClose: () {});
    }
  }
}
