part of 'home_screen.dart';

extension HomeAction on _HomeScreenState {
  void goToShoppingScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShoppingScreen(),
        ));
  }

  

  void _blocListener(BuildContext context, GetUserState state) {
    // logger.d('change state', state);
    // _refreshController
    //   ..refreshCompleted()
    //   ..loadComplete();
    if (state is GetUserSuccessState &&
        state.status == BlocStatusState.success) {
      showToast('Đã tải dữ liệu thành công');
    }
  }
}
