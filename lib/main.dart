import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/common_widget/enum_common.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'classes/language.dart';
import 'common/service/navigation/navigation_observer.dart';
import 'common/service/navigation/navigation_service.dart';
import 'di/di.dart';
import 'package:camera/camera.dart';
import 'presentation/common_widget/assets.dart';
import 'presentation/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_health_check/common/service/firebase/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! Phải gọi function configureDependencies() trước khi run App để sử dụng được DI
  configureDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await notificationData.saveDelayTime(2000);
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  runApp(
    const MyApp(),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
  void initState() {
    // TODO: implement initState
    super.initState();
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
      title: 'TeleHealth',
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 1000)).then((value) async {
      // Navigator.pushNamed(context, RouteList.OCR_screen);
      bool isLogin = userDataData.isLogin ?? false;
      if (isLogin) {
        if (userDataData.getUser() != null) {
          if (userDataData.getUser()!.role == UserRole.patient) {
            Navigator.pushNamed(
              context,
              RouteList.selectEquip,
            );
          } else if (userDataData.getUser()!.role == UserRole.doctor ||
              userDataData.getUser()!.role == UserRole.relative) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, RouteList.patientList,
                arguments: userDataData.getUser()!.id!);
          } else if (userDataData.getUser()!.role == UserRole.admin) {
            Navigator.pushNamed(context, RouteList.doctorList,
                arguments: userDataData.getUser()!.id!);
          }
        } else {
          Navigator.pushNamed(context, RouteList.login);
        }
      } else {
        Navigator.pushNamed(context, RouteList.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Image.asset(
          Assets.teleHealth,
          scale: 6,
        ),
      ),
    );
  }
}
