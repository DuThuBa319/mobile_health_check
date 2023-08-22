import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'classes/language_constant.dart';
import 'di/di.dart';
import 'package:camera/camera.dart';
import 'presentation/common_widget/assets.dart';
import 'presentation/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_health_check/common/service/firebase/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initOneSignal();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

Future<void> initOneSignal() async {
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("eb1e614e-54fe-4824-9c1a-aad236ec92d3");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  final status = await Permission.notification.request();
  if (status.isDenied) {
    await Permission.notification.request();
    showToast("Bạn chưa bật cho phép thông báo");
    //SHOW DIALOG with 2 button => setting and cancel, if user press "setting" =>  final status = await OneSignal.Notifications.requestPermission(true);
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    //  await openAppSettings(); ==> nằm trong Dialog làm phía trên
  }
  OneSignal.User.pushSubscription.addObserver((state) {
    print(state.current.jsonRepresentation());
  });
  OneSignal.Notifications.addPermissionObserver((state) {
    print("Has permission $state");
  });
  OneSignal.Notifications.addClickListener((event) {
    print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    // Navigator.pushNamed(, routeName)
  });

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    /// preventDefault to not display the notification
    event.preventDefault();

    /// Do async work
    // debugPrint("^^${event.notification.body}");

    /// notification.display() to display after preventing default
    event.notification.display();
  });
  // OneSignal.InAppMessages.addClickListener((event) {
  //   print(
  //       "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}");
  // });
  // OneSignal.InAppMessages.addWillDisplayListener((event) {
  //   print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
  // });
  // OneSignal.InAppMessages.addDidDisplayListener((event) {
  //   print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
  // });
  // OneSignal.InAppMessages.addWillDismissListener((event) {
  //   print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
  // });
  // OneSignal.InAppMessages.addDidDismissListener((event) {
  //   print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
  // });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
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
      Navigator.pushNamed(context, RouteList.selectEquip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logoFlutter,
          scale: 3,
        ),
      ),
    );
  }
}
