import 'package:common_project/presentation/bloc/login/login_bloc.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_bloc.dart';
import 'package:common_project/presentation/common_widget/enum_common.dart';
import 'package:common_project/presentation/modules/OCR_scanner/OCR_scanner_screen.dart';
import 'package:common_project/presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'package:common_project/presentation/modules/camera_demo/camera_demo_screen.dart';
import 'package:common_project/presentation/modules/history/bloc/history_bloc.dart';
import 'package:common_project/presentation/modules/history/history_screen.dart';

import 'package:common_project/presentation/modules/login_screen/login_screen.dart';
import 'package:common_project/presentation/modules/pick_equipment/pick_equipment_screen.dart';
import 'package:common_project/presentation/modules/user_profile/user_profile_screen.dart';
import 'package:common_project/presentation/modules/user_profile/user_regist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/camera_demo/camera_bloc/camera_bloc.dart';

import '../modules/home/home_screen.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => getIt<LoginBloc>(),
              child: const LoginScreen(),
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

      case '/ocr_screen':
        final task = routeSettings.arguments as MeasuringTask;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<OCRScannerBloc>(),
                  )
                ],
                child: OCRScannerScreen(
                  task: task,
                ));
          },
        );
      case '/camera':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => CameraBloc(),
              )
            ], child: const CameraScreen());
          },
        );
      case '/history':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: const HistoryScreen());
          },
        );
      // case '/trend':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return const BloodPressureDetailScreen();
      //     },
      //   );
      case '/select':
        return MaterialPageRoute(
          builder: (context) {
            return const PickEquipmentScreen();
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
