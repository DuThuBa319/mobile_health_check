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
    if (state is WifiDisconnectState &&
        state.status == BlocStatusState.success) {
      showNoticeDialog(
          context: context,
          message: translation(context).wifiDisconnect,
          title: translation(context).notification,
          titleBtn: translation(context).exit);
    }
  }
}
