part of 'notification_screen.dart';

// ignore: library_private_types_in_public_api
extension NotificationScreenAction on _NotificationListState {
  void _blocListener(BuildContext context, NotificationState state) {
    //? loading
    if (state.status == BlocStatusState.loading) {
      if (state is GetNotificationListState) {
        showToast(translation(context).loadingData);
      }
    }

    //? success
    if (state.status == BlocStatusState.success) {
      if (state is GetNotificationListState) {
        showToast(translation(context).dataLoaded);
      }
      if (state is DeleteNotificationState) {
        showToast(translation(context).deleteNotificationSuccessfully);
      }
    }

    //? Failure
    if (state.status == BlocStatusState.failure) {
      if (state.viewModel.isWifiDisconnect == true) {
        showExceptionDialog(
            context: context,
            message: translation(context).wifiDisconnect,
            titleBtn: translation(context).exit);
      }
    }
  }
}
