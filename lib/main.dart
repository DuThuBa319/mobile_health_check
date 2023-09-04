import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classes/language_constant.dart';
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
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initOneSignal();
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
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      title: 'Health Check App',
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
    Future.delayed(const Duration(seconds: 2)).then((value) {
      // Navigator.pushNamed(context, RouteList.OCR_screen);

      final isLogin = userDataData.isLogin;
      if (isLogin == true) {
        //  Navigato r.pushNamed(context, RouteList.selectEquip);
        if (userDataData.getUser()!.role == "doctor") {
          Navigator.pushNamed(context, RouteList.patientList,
              arguments: userDataData.getUser()!.id!);
        } else if (userDataData.getUser()!.role == "patient") {
          Navigator.pushNamed(
            context,
            RouteList.selectEquip,
          );
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
