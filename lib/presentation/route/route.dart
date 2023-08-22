import 'package:mobile_health_check/presentation/modules/camera_demo/camera_demo_screen.dart';

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
import '../modules/camera_demo/camera_bloc/camera_bloc.dart';
import '../modules/login_screen/login/login_bloc.dart';
import '../modules/patient/patient_list/patients_list_screen.dart';
import '../modules/patient/patient_list_&_infor_bloc/get_patient_bloc.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case '/home':
      //   return MaterialPageRoute(builder: (context) => const HomeScreen());
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

      // case '/ocr_screen':
      //   final task = routeSettings.arguments as MeasuringTask;
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return MultiBlocProvider(
      //           providers: [
      //             BlocProvider(
      //               create: (context) => getIt<OCRScannerBloc>(),
      //             )
      //           ],
      //           child: OCRScannerScreen(
      //             task: task,
      //           ));
      //     },
      //   );
      case '/camera':
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
      // case '/bloodPressureHistory':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return MultiBlocProvider(providers: [
      //         BlocProvider(
      //           create: (context) => getIt<HistoryBloc>(),
      //         )
      //       ], child: const BloodPressureHistoryScreen());
      //     },
      //   );
      // case '/bloodSugarHistory':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return MultiBlocProvider(providers: [
      //         BlocProvider(
      //           create: (context) => getIt<HistoryBloc>(),
      //         )
      //       ], child: const BloodSugarHistoryScreen());
      //     },
      //   );
      // case '/temperatureHistory':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return MultiBlocProvider(providers: [
      //         BlocProvider(
      //           create: (context) => getIt<HistoryBloc>(),
      //         )
      //       ], child: const TemperatureScreen());
      //     },
      //   );
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
