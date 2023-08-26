import 'package:mobile_health_check/presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'package:mobile_health_check/presentation/modules/camera_demo/camera_demo_screen.dart';
import 'package:mobile_health_check/presentation/modules/history/temperature_history_screen/temperature_history_screen.dart';

import 'package:mobile_health_check/presentation/modules/login_screen/login_screen.dart';
import 'package:mobile_health_check/presentation/modules/pick_equipment/pick_equipment_screen.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/doctor_password_setting.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/doctor_phone_setting.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/doctor_setting_menu.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/language_setting.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_widget/enum_common.dart';
import '../modules/OCR_scanner/OCR_scanner_screen.dart';
import '../modules/camera_demo/camera_bloc/camera_bloc.dart';
import '../modules/history/blood_pressure_history_screen/blood_pressure_history_screen.dart';
import '../modules/history/blood_sugar_history_screen/blood_sugar_history_screen.dart';
import '../modules/history/history_bloc/history_bloc.dart';
import '../modules/login_screen/login/login_bloc.dart';
import '../modules/patient/patient_list/patients_list_screen.dart';
import '../modules/patient/patient_list_&_infor_bloc/get_patient_bloc.dart';
import '../modules/patient/patient_profile/patient_infor_screen.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetUserBloc>(
              create: (context) => getIt<GetUserBloc>(),
              child: HomeScreen(id: id),
            );
          },
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
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
      // case '/regist_user':
      //   final args = routeSettings.arguments as GetUserBloc;
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return RegistScreen(
      //         userBLoc: args,
      //       );
      //     },
      //   );

      case '/ocr_screen':
        final task = routeSettings.arguments as MeasuringTask;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider<OCRScannerBloc>(
                    create: (context) => getIt<OCRScannerBloc>(),
                  )
                ],
                child: OCRScannerScreen(
                  task: task,
                ));
          },
        );
      case '/camera':
        final id = routeSettings.arguments as String;

        final task = routeSettings.arguments as MeasuringTask;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => CameraBloc(),
              )
            ], child: CameraScreen(task: task));
          },
        );
      case '/bloodPressureHistory':
        final id = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: BloodPressureHistoryScreen(id: id));
          },
        );
      case '/bloodSugarHistory':
        final id = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: BloodSugarHistoryScreen(id: id));
          },
        );
      case '/temperatureHistory':
        final id = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: TemperatureHistoryScreen(id: id));
          },
        );
      case '/setting':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingMenu();
          },
        );
      case '/settingDrPhone':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingDrPhone();
          },
        );
      case '/settingLanguage':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingLanguage();
          },
        );
      case '/settingDrPass':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingDrPassword();
          },
        );

      case '/select':
        return MaterialPageRoute(
          builder: (context) {
            return const PickEquipmentScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetUserBloc>(
              create: (context) => getIt<GetUserBloc>(),
              child: const UserListScreen(),
            );
          },
        );
    }
  }
}
