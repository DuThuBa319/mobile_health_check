import 'package:common_project/presentation/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/di.dart';
import 'presentation/route/route.dart';

void main() {
  // SỬA CHỖ NÀY

  // 2 DÒNG Ở TRÊN SỬA
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
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
      home: const HomeScreen(),
    );
  }
}
