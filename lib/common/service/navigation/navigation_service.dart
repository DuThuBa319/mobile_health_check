import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // final GlobalKey<NavigatorState> translationKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, {Object? argument}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: argument);
  }

  // AppLocalizations translateWithoutContext(String? text) {
  //   return AppLocalizations.of(translationKey.currentContext!)!;
  // }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
