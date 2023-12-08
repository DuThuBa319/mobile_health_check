part of 'spo2_reading_screen.dart';

// ignore: library_private_types_in_public_api
extension Spo2ReadingScreenAction on _Spo2ReadingScreenState {
  void blocListener(BuildContext context, OCRScannerState state) async {
    if (state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state.status == BlocStatusState.success) {
      if (state is UploadSpo2DataState) {
        showSuccessDialog(
            context: context,
            message: translation(context).uploadSpo2Successfully,
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
