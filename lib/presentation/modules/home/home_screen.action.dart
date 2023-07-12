part of 'home_screen.dart';

extension HomeAction on _HomeScreenState {
  void goToShoppingScreen() {
    Navigator.pushNamed(context, RouteList.shoppingCart);
  }

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

  void goToDailyWeatherScreen() {
    Navigator.pushNamed(context, RouteList.example);
  }
}
