part of 'notification_screen.dart';

// ignore: library_private_types_in_public_api
extension NotificationScreenAction on _NotificationListState {
  void _blocListener(BuildContext context, NotificationState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }
    if (state is GetNotificationListState &&
        state.status == BlocStatusState.success) {
      showToast('Tải dữ liệu thành công');
    }
  }
}
