import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/daily_weather_bloc/daily_weather_bloc.dart';
import '../modules/daily_weather/daily_weather_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/shopping_cart/shopping_cart.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'shop':
        return MaterialPageRoute(
          builder: (context) => const ShoppingScreen(),
        );
      case 'example':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<DailyWeatherBloc>(
              create: (context) => getIt<DailyWeatherBloc>(),
              child: const DailyWeatherScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
