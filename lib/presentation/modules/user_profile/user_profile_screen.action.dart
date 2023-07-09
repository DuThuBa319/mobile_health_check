part of 'user_profile_screen.dart';

extension UserListScreenAction on _UserListState {
  void _Listener(BuildContext context, GetUserState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetUserSuccessState) {
      showToast('Load User Successfully');
    }
  }

}
