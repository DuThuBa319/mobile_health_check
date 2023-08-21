part of 'patients_list_screen.dart';

extension UserListScreenAction on _UserListState {
  void _blocListener(BuildContext context, GetUserState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetListUserState && state.status == BlocStatusState.loading) {
      showToast('Loading');
    }
    if (state is GetListUserState && state.status == BlocStatusState.success) {
      showToast('Loaded');
    }
    if (state is RegistUserState && state.status == BlocStatusState.success) {
      showToast('Regist User successfully');
      userBloc.add(GetListUserEvent());
      Navigator.pop(context);
    }
  }

  void gotoRegistUserScreen() {
    Navigator.pushNamed(context, RouteList.registUser, arguments: userBloc);
  }
}
