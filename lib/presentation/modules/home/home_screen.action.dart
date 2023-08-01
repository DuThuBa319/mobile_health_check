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

  void goToHourlyTemperatureScreen() {
    Navigator.pushNamed(context, RouteList.hourlyTemperature);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
