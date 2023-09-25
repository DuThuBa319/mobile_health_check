import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classes/language.dart';
import 'common/service/navigation/navigation_observer.dart';
import 'common/service/navigation/navigation_service.dart';
import 'di/di.dart';
import 'package:camera/camera.dart';
import 'domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import 'presentation/common_widget/assets.dart';
import 'presentation/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_health_check/common/service/firebase/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initOneSignal();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  // String screenRoute = '/';
  // Object? argument;
  // OneSignal.shared.setNotificationOpenedHandler((openedResult) {
  //   NotificationBloc notificationBloc = getIt<NotificationBloc>();
  //   if (openedResult.notification.additionalData?["Indicator"] ==
  //       "BloodPressure") {
  //     String? patientId =
  //         openedResult.notification.additionalData?["patientId"];

  //     String? patientName =
  //         openedResult.notification.additionalData?["PatientName"];
  //     int? sys =
  //         int.parse(openedResult.notification.additionalData?["Systolic"]);
  //     int? pulse =
  //         int.parse(openedResult.notification.additionalData?["PulseRate"]);
  //     String dateString =
  //         openedResult.notification.additionalData?["UpdatedDate"];
  //     DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
  //     notificationBloc.add(
  //       SetReadedNotificationEvent(
  //         notificationId: openedResult.notification.notificationId,
  //       ),
  //     );
  //     final BloodPressureEntity bloodPressureEntity = BloodPressureEntity(
  //       imageLink: openedResult.notification.additionalData?["ImageLink"],
  //       updatedDate: updatedDate,
  //       sys: sys,
  //       pulse: pulse,
  //     );
  //     final NotificationEntity notificationEntity = NotificationEntity(
  //         bloodPressureEntity: bloodPressureEntity,
  //         patientName: patientName,
  //         patientId: patientId,
  //         sendDate: updatedDate);

  //     //  showToast(translation(context).waitForSeconds);
  //     screenRoute = RouteList.bloodPressuerNotificationReading;
  //     argument = notificationEntity;
  //     setState(() {
  //       injector<NavigationService>().navigateTo(
  //           RouteList.bloodPressuerNotificationReading,
  //           argument: notificationEntity);
  //     });
  //   }
  //   if (openedResult.notification.additionalData?["Indicator"] ==
  //       "BodyTemperature") {
  //     String? patientId =
  //         openedResult.notification.additionalData?["patientId"];
  //     String? patientName =
  //         openedResult.notification.additionalData?["PatientName"];
  //     String dateString =
  //         openedResult.notification.additionalData?["UpdatedDate"];
  //     DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
  //     double? value = double.parse(
  //         openedResult.notification.additionalData?["BodyTemperature"]);
  //     debugPrint("$value");
  //     notificationBloc.add(
  //       SetReadedNotificationEvent(
  //         notificationId: openedResult.notification.notificationId,
  //       ),
  //     );

  //     final TemperatureEntity temperatureEntity = TemperatureEntity(
  //       imageLink: openedResult.notification.additionalData?["ImageLink"],
  //       temperature: value,
  //       updatedDate: updatedDate,
  //     );
  //     final NotificationEntity notificationEntity = NotificationEntity(
  //         bodyTemperatureEntity: temperatureEntity,
  //         patientName: patientName,
  //         patientId: patientId,
  //         sendDate: updatedDate);
  //     // showToast(translation(context).waitForSeconds);
  //     screenRoute = RouteList.bodyTemperatureNotificationReading;
  //     argument = notificationEntity;
  //     injector<NavigationService>().navigateTo(
  //         RouteList.bodyTemperatureNotificationReading,
  //         argument: notificationEntity);

  //     // Navigator.pushNamed(
  //     //     context, RouteList.bodyTemperatureNotificationReading,
  //     //     arguments: notificationEntity);
  //   }
  //   if (openedResult.notification.additionalData?["Indicator"] ==
  //       "BloodSugar") {
  //     String? patientId =
  //         openedResult.notification.additionalData?["patientId"];
  //     String? patientName =
  //         openedResult.notification.additionalData?["PatientName"];
  //     String dateString =
  //         openedResult.notification.additionalData?["UpdatedDate"];
  //     DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
  //     notificationBloc.add(
  //       SetReadedNotificationEvent(
  //         notificationId: openedResult.notification.notificationId,
  //       ),
  //     );
  //     double? value =
  //         double.parse(openedResult.notification.additionalData?["BloodSugar"]);
  //     debugPrint("$value");
  //     final BloodSugarEntity bloodSugarEntity = BloodSugarEntity(
  //       imageLink: openedResult.notification.additionalData?["ImageLink"],
  //       bloodSugar: value,
  //       updatedDate: updatedDate,
  //     );
  //     final NotificationEntity notificationEntity = NotificationEntity(
  //         bloodSugarEntity: bloodSugarEntity,
  //         patientName: patientName,
  //         patientId: patientId,
  //         sendDate: updatedDate);
  //     screenRoute = RouteList.bloodSugarNotificationReading;
  //     argument = notificationEntity;
  //     injector<NavigationService>().navigateTo(
  //         RouteList.bloodSugarNotificationReading,
  //         argument: notificationEntity);
  //   }
  //   if (openedResult.notification.additionalData?["Indicator"] == "SpO2") {
  //     String? patientId =
  //         openedResult.notification.additionalData?["patientId"];
  //     String? patientName =
  //         openedResult.notification.additionalData?["PatientName"];
  //     String dateString =
  //         openedResult.notification.additionalData?["UpdatedDate"];
  //     DateTime updatedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
  //     int? value = int.parse(openedResult.notification.additionalData?["SpO2"]);
  //     notificationBloc.add(
  //       SetReadedNotificationEvent(
  //         notificationId: openedResult.notification.notificationId,
  //       ),
  //     );
  //     debugPrint("$value");
  //     final Spo2Entity spo2Entity = Spo2Entity(
  //       imageLink: openedResult.notification.additionalData?["ImageLink"],
  //       spo2: value,
  //       updatedDate: updatedDate,
  //     );

  //     final NotificationEntity notificationEntity = NotificationEntity(
  //         spo2Entity: spo2Entity,
  //         patientName: patientName,
  //         patientId: patientId,
  //         sendDate: updatedDate);
  //     //     screenRoute = RouteList.bodyTemperatureNotificationReading;
  //     // argument = notificationEntity;
  //     // injector<NavigationService>().navigateTo(
  //     //     RouteList.bodyTemperatureNotificationReading,
  //     //     argument: notificationEntity);
  //   }
  // });

  runApp(
    const MyApp(
        // argument: argument,
        // screenRoute: screenRoute,
        ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.argument, this.screenRoute});
  final String? screenRoute;
  final Object? argument;
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
    // ignore: unrelated_type_equality_checks
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      if (_locale?.languageCode == 'en') {
        notificationData.saveLocale(1);
      }
      if (_locale?.languageCode == 'vi') {
        notificationData.saveLocale(2);
      }
      // ignore: unrelated_type_equality_checks
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: injector<NavigationService>().navigatorKey,
      navigatorObservers: [myNavigatorObserver],
      locale: _locale,
      debugShowCheckedModeBanner: false,
      title: 'Health Check App',
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
          argument: widget.argument, screenRoute: widget.screenRoute),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.argument, this.screenRoute});
  final String? screenRoute;
  final Object? argument;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      // Navigator.pushNamed(context, RouteList.OCR_screen);

      final isLogin = userDataData.isLogin;
      if (isLogin == true) {
        if (widget.screenRoute == null) {
          if (userDataData.getUser()!.role == "doctor") {
            final NotificationUsecase count = getIt<NotificationUsecase>();
            final unreadCount = await count
                .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
            notificationData.saveUnreadNotificationCount(unreadCount ?? 0);
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, RouteList.patientList,
                arguments: userDataData.getUser()!.id!);
          } else if (userDataData.getUser()!.role == "patient") {
            Navigator.pushNamed(
              context,
              RouteList.selectEquip,
            );
          }
        }
        if (widget.screenRoute == RouteList.bloodPressuerNotificationReading) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, widget.screenRoute!,
              arguments: widget.argument);
        }
      } else {
        Navigator.pushNamed(context, RouteList.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.appLogo,
          scale: 3,
        ),
      ),
    );
  }
}
