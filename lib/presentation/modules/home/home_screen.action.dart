part of 'home_screen.dart';

extension HomeAction on _HomeScreenState {
  void goToShoppingScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShoppingScreen(),
        ));
  }

  void goToOCRScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OCRScannerScreen(),
        ));
  }
}
