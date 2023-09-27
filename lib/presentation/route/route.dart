import 'package:mobile_health_check/presentation/modules/OCR_scanner/ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'package:mobile_health_check/presentation/modules/OCR_scanner/read_blood_pressure_reading_screen.dart';
import 'package:mobile_health_check/presentation/modules/history/temperature_history_screen/temperature_history_screen.dart';

import 'package:mobile_health_check/presentation/modules/login_screen/login_screen.dart';
import 'package:mobile_health_check/presentation/modules/pick_equipment/pick_equipment_screen.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/blood_pressure_entity.dart';
import '../../domain/entities/blood_sugar_entity.dart';
import '../../domain/entities/spo2_entity.dart';
import '../../domain/entities/temperature_entity.dart';
import '../common_widget/enum_common.dart';
import '../modules/OCR_scanner/OCR_scanner_screen.dart';
import '../modules/OCR_scanner/blood_glucose_reading_screen.dart';
import '../modules/OCR_scanner/spo2_reading_screen.dart';
import '../modules/OCR_scanner/temperature_reading_screen.dart';
import '../modules/history/blood_pressure_history_screen/blood_pressure_history_screen.dart';
import '../modules/history/blood_sugar_history_screen/blood_sugar_history_screen.dart';
import '../modules/history/detail_screen/blood_pressure_detail.dart';
import '../modules/history/detail_screen/blood_sugar_detail.dart';
import '../modules/history/detail_screen/spo2_detail.dart';
import '../modules/history/detail_screen/temperature_detail.dart';
import '../modules/history/history_bloc/history_bloc.dart';
import '../modules/history/spo2_history_screen/spo2_history_screen.dart';
import '../modules/login_screen/login/login_bloc.dart';
import '../modules/login_screen/signUp_screen.dart';
import '../modules/notification_onesignal/bloc/notification_bloc.dart';
import '../modules/notification_onesignal/detail_screen/blood_pressure_reading.dart';
import '../modules/notification_onesignal/detail_screen/blood_sugar_reading.dart';
import '../modules/notification_onesignal/detail_screen/spo2_reading.dart';
import '../modules/notification_onesignal/detail_screen/temperature_reading.dart';
import '../modules/notification_onesignal/notification_screen.dart';
import '../modules/patient/bloc/get_patient_bloc.dart';
import '../modules/patient/patient_list/patients_list_screen.dart';
import '../modules/patient/patient_list/widget/add_patient_screen.dart';
import '../modules/patient/patient_profile/add_relative_screen.dart';
import '../modules/patient/patient_profile/patient_infor_screen.dart';
import '../modules/setting_screen/doctor_or_relative_setting/doctor_or_relative_language_setting.dart';
import '../modules/setting_screen/doctor_or_relative_setting/doctor_relative_password_setting.dart';
import '../modules/setting_screen/doctor_or_relative_setting/doctor_or_relative_phone_setting.dart';
import '../modules/setting_screen/doctor_or_relative_setting/doctor_or_relative_setting_menu.dart';
import '../modules/setting_screen/patient_setting/patient_language_setting.dart';
import '../modules/setting_screen/patient_setting/patient_password_setting.dart';
import '../modules/setting_screen/profile_setting.dart';
import '../modules/setting_screen/patient_setting/patient_setting_menu.dart';

class AppRoute {
  static GetIt getIt = GetIt.instance;

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/patientInfor':
        final patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientInforScreen(patientId: patientId),
            );
          },
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => getIt<LoginBloc>(),
              child: const LoginScreen(),
            );
          },
        );

      case '/patient_list':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientListScreen(id: id),
            );
          },
        );

      case '/signUp':
        // final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return const SignUpDoctorScreen();
          },
        );
      case '/addRelative':
        final map = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: AddRelativeScreen(
                  patientId: map["patientId"], patientBloc: map["patientBloc"]),
            );
          },
        );
      case '/addPatient':
        final bloc = routeSettings.arguments as GetPatientBloc;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: AddPatientScreen(getPatientBloc: bloc),
            );
          },
        );

      // case '/regist_Patient':
      //   final args = routeSettings.arguments as GetPatientBloc;
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return RegistScreen(
      //         PatientBLoc: args,
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
      case '/bloodPressureScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const BloodPressureReadingScreen());
          },
        );
      case '/bloodGlucoseScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const BloodGlucoseReadingScreen());
          },
        );
      case '/temperatureScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const TemperatureReadingScreen());
          },
        );
      case '/spo2Screen':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<OCRScannerBloc>(
                create: (context) => getIt<OCRScannerBloc>(),
              )
            ], child: const Spo2ReadingScreen());
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
            return BlocProvider<HistoryBloc>(
              create: (context) => getIt<HistoryBloc>(),
              child: TemperatureHistoryScreen(id: id),
            );
          },
        );
      case '/spo2History':
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => getIt<HistoryBloc>(),
              )
            ], child: Spo2HistoryScreen(id: id));
          },
        );
      case '/bloodPressuerDetail':
        final response = routeSettings.arguments as BloodPressureEntity;
        return MaterialPageRoute(
            builder: (context) => BloodPressureDetailScreen(
                  bloodPressureEntity: response,
                ));
      case '/bloodSugarDetail':
        final response = routeSettings.arguments as BloodSugarEntity;
        return MaterialPageRoute(
            builder: (context) => BloodSugarDetailScreen(
                  bloodSugarEntity: response,
                ));
      case '/bodyTemperatureDetail':
        final response = routeSettings.arguments as TemperatureEntity;
        return MaterialPageRoute(
            builder: (context) => TemperatureDetailScreen(
                  temperatureEntity: response,
                ));
      case '/spo2Detail':
        final response = routeSettings.arguments as Spo2Entity;
        return MaterialPageRoute(
            builder: (context) => Spo2DetailScreen(
                  spo2Entity: response,
                ));

      case '/bloodPressuerNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BloodPressureNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/bloodSugarNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BloodSugarNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/bodyTemperatureNotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => TemperatureNotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));
      case '/spo2NotificationReading':
        final response = routeSettings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => Spo2NotificationReadingScreen(
                  notificationEntity: response["notificationEntity"],
                  navigateFromCell: response["navigateFromCell"],
                ));

      case '/notification':
        final id = routeSettings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<NotificationBloc>(
              create: (context) => getIt<NotificationBloc>(),
              child: NotificationScreen(id: id),
            );
          },
        );

      case '/setting':
        return MaterialPageRoute(builder: (context) {
          return const SettingMenu();
        });
      case '/patientSetting':
        return MaterialPageRoute(builder: (context) {
          return const PatientSettingMenu();
        });

      case '/settingProfile':
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: const SettingProfile(),
            );
          },
        );
      case '/patientSettingPass':
        return MaterialPageRoute(builder: (context) {
          return const SettingPatientPassword();
        });
      case '/patientSettingLanguage':
        return MaterialPageRoute(builder: (context) {
          return const SettingPatientLanguage();
        });
      case '/settingDrPhone':
        return MaterialPageRoute(
          builder: (context) {
            return const SettingDrOrRePhone();
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
            return const SettingDrOrRePassword();
          },
        );

      case '/select':
        return MaterialPageRoute(
          builder: (context) {
            return const PickEquipmentScreen();
          },
        );
      default:
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<GetPatientBloc>(
              create: (context) => getIt<GetPatientBloc>(),
              child: PatientListScreen(id: id),
            );
          },
        );
    }
  }
}
