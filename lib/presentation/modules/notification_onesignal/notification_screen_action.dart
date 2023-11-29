part of 'notification_screen.dart';

// ignore: library_private_types_in_public_api
extension NotificationScreenAction on _NotificationListState {
  void _blocListener(BuildContext context, NotificationState state) {
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.loading) {
      showToast(translation(context).loadingData);
    }
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).dataLoaded);
    }
    if (state is DeleteNotificationState &&
        state.status == BlocStatusState.success) {
      showToast(translation(context).deleteNotificationSuccessfully);
    }
   if (state.status == BlocStatusState.failure &&
                state.viewModel.errorMessage ==
                    translation(context).wifiDisconnect) {
      showExceptionDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          titleBtn: translation(context).exit);
    }
  }
}
