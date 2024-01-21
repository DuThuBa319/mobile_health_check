part of 'notification_screen.dart';

// ignore: library_private_types_in_public_api
extension NotificationScreenAction on _NotificationListState {
  void _blocListener(BuildContext context, NotificationState state) {
    //? loading
    if (state.status == BlocStatusState.loading) {}

    //? success
    if (state.status == BlocStatusState.success) {
      if (state is GetNotificationListState ||
          state is RefreshNotificationListState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).dataLoaded);
      }
      if (state is DeleteNotificationState) {
        showToast(
            context: context,
            status: ToastStatus.success,
            toastString: translation(context).deleteNotificationSuccessfully);
      }
    }

    //? Failure
    if (state.status == BlocStatusState.failure) {
      showToast(
          context: context,
          status: ToastStatus.error,
          toastString: state.viewModel.errorMessage!);
    }
  }
}
