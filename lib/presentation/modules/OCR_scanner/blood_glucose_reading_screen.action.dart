part of 'blood_glucose_reading_screen.dart';

// ignore: library_private_types_in_public_api
extension BloodGlucoseReadingScreenAction on _BloodGlucoseReadingScreenState {
  void blocListener(BuildContext context, OCRScannerState state) async {
    if (state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state.status == BlocStatusState.success) {
      if (state is UploadBloodGlucoseDataState) {
        successAlert(
          context,
          alertText: translation(context).uploadSuccessfully,
        );
      }
      showToast(translation(context).dataLoaded);
    }
  }
}
