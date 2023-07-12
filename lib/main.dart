import 'package:common_project/presentation/modules/home/home_screen.dart';
import 'package:common_project/presentation/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'di/di.dart';

void main() {
  // 2 DÒNG Ở TRÊN SỬA
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  static GetIt getIt = GetIt.instance;

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Common Project',
        onGenerateRoute: AppRoute.onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen()
        // home: BlocProvider(
        //   create: (context) => LoginBloc(),
        //   child: const LoginScreen(),
        // ),
        );
  }
}
