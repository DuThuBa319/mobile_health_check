import 'package:common_project/presentation/bloc/hourly_temperarute_bloc/hourly_temperature_bloc.dart';
import 'package:common_project/presentation/bloc/login/login_bloc.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:common_project/presentation/modules/hourly_temperature/hourly_temperature_screen.dart';
import 'package:common_project/presentation/modules/login_screen/login_screen.dart';
import 'package:common_project/presentation/modules/user_profile/user_profile_screen.dart';
import 'package:common_project/presentation/modules/user_profile/user_regist_screen.dart';
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
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
        case '/login':
        return  MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => getIt<LoginBloc>(),
              child: const LoginScreen(),
            );
          },
        );
      case '/shop':
        return MaterialPageRoute(
          builder: (context) => const ShoppingScreen(),
        );
      case '/example':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<DailyWeatherBloc>(
              create: (context) => getIt<DailyWeatherBloc>(),
              child: const DailyWeatherScreen(),
            );
          },
        );
      case '/user_list':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetUserBloc>(
              create: (context) => getIt<GetUserBloc>(),
              child: const UserListScreen(),
            );
          },
        );
      case '/regist_user':
        final args = routeSettings.arguments as GetUserBloc;
        return MaterialPageRoute(
          builder: (context) {
            return RegistScreen(
              userBLoc: args,
            );
          },
        );
      case '/hourly_Temperature':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HourlyTemperatureBloc>(
              create: (context) => getIt<HourlyTemperatureBloc>(),
              child: const HourlyTemperatureScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
