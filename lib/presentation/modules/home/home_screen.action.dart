part of 'home_screen.dart';

extension HomeAction on _HomeScreenState {
  void goToOCRScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => ImagePickerBloc(),
            )
          ], child: const OCRScannerScreen()),
        ));
  }

  void goToShoppingScreen() {
    Navigator.pushNamed(context, RouteList.shoppingCart);
  }

  void goToDailyWeatherScreen() {
    Navigator.pushNamed(context, RouteList.example);
  }

  void goToUserList() {
    Navigator.pushNamed(context, RouteList.userList);
  }
}
