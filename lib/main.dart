import 'package:common_project/presentation/common_widget/assets.dart';
import 'package:common_project/presentation/route/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/di.dart';
import 'package:camera/camera.dart';
import 'presentation/route/route.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
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
      debugShowCheckedModeBanner: false,
      title: 'Common Project',
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
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 2)).then((value) {
      // Navigator.pushNamed(context, RouteList.OCR_screen);
      Navigator.pushNamed(context, RouteList.home);
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
// import 'dart:io';
// import 'dart:math';
// import 'package:image/image.dart' as img;
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//           highlightColor: const Color(0xFFD0996F),
//           canvasColor: const Color(0xFFFDF5EC),
//           textTheme: TextTheme(
//             headlineSmall: ThemeData.light()
//                 .textTheme
//                 .headlineSmall!
//                 .copyWith(color: const Color(0xFFBC764A)),
//           ),
//           iconTheme: IconThemeData(
//             color: Colors.grey[600],
//           ),
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Color(0xFFBC764A),
//             centerTitle: false,
//             foregroundColor: Colors.white,
//             actionsIconTheme: IconThemeData(color: Colors.white),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateColor.resolveWith(
//                   (states) => const Color(0xFFBC764A)),
//             ),
//           ),
//           outlinedButtonTheme: OutlinedButtonThemeData(
//             style: ButtonStyle(
//               foregroundColor: MaterialStateColor.resolveWith(
//                 (states) => const Color(0xFFBC764A),
//               ),
//               side: MaterialStateBorderSide.resolveWith(
//                   (states) => const BorderSide(color: Color(0xFFBC764A))),
//             ),
//           ),
//           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
//               .copyWith(background: const Color(0xFFFDF5EC))),
//       home: const HomePage(title: 'Image Cropper Demo'),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   final String title;

//   const HomePage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   XFile? _pickedFile;
//   CroppedFile? _croppedFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: !kIsWeb ? AppBar(title: Text(widget.title)) : null,
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (kIsWeb)
//             Padding(
//               padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
//               child: Text(
//                 widget.title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium!
//                     .copyWith(color: Theme.of(context).highlightColor),
//               ),
//             ),
//           Expanded(child: _body()),
//         ],
//       ),
//     );
//   }

//   Widget _body() {
//     if (_croppedFile != null || _pickedFile != null) {
//       return _imageCard();
//     } else {
//       return _uploaderCard();
//     }
//   }

//   Widget _imageCard() {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
//             child: Card(
//               elevation: 4.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
//                 child: _image(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 24.0),
//           _menu(),
//         ],
//       ),
//     );
//   }

//   Widget _image() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     if (_croppedFile != null) {
//       final path = _croppedFile!.path;
//       return ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: 0.8 * screenWidth,
//           maxHeight: 0.7 * screenHeight,
//         ),
//         child: kIsWeb ? Image.network(path) : Image.file(File(path)),
//       );
//     } else if (_pickedFile != null) {
//       final path = _pickedFile!.path;
//       return ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: 0.8 * screenWidth,
//           maxHeight: 0.7 * screenHeight,
//         ),
//         child: kIsWeb ? Image.network(path) : Image.file(File(path)),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _menu() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton(
//           onPressed: () {
//             _clear();
//           },
//           backgroundColor: Colors.redAccent,
//           tooltip: 'Delete',
//           child: const Icon(Icons.delete),
//         ),
//         if (_croppedFile == null)
//           Padding(
//             padding: const EdgeInsets.only(left: 32.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _cropImage();
//               },
//               backgroundColor: const Color(0xFFBC764A),
//               tooltip: 'Crop',
//               child: const Icon(Icons.crop),
//             ),
//           )
//       ],
//     );
//   }

//   Widget _uploaderCard() {
//     return Center(
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: SizedBox(
//           width: kIsWeb ? 380.0 : 320.0,
//           height: 300.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: DottedBorder(
//                     radius: const Radius.circular(12.0),
//                     borderType: BorderType.RRect,
//                     dashPattern: const [8, 4],
//                     color: Theme.of(context).highlightColor.withOpacity(0.4),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.image,
//                             color: Theme.of(context).highlightColor,
//                             size: 80.0,
//                           ),
//                           const SizedBox(height: 24.0),
//                           Text(
//                             'Upload an image to start',
//                             style: kIsWeb
//                                 ? Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall!
//                                     .copyWith(
//                                         color: Theme.of(context).highlightColor)
//                                 : Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .copyWith(
//                                         color:
//                                             Theme.of(context).highlightColor),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 24.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _uploadImage();
//                   },
//                   child: const Text('Upload'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _cropImage() async {
//     if (_pickedFile != null) {
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: _pickedFile!.path,
//         compressFormat: ImageCompressFormat.jpg,
//         compressQuality: 100,
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'Cropper',
//               toolbarColor: Colors.deepOrange,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//           WebUiSettings(
//             context: context,
//             presentStyle: CropperPresentStyle.dialog,
//             boundary: const CroppieBoundary(
//               width: 520,
//               height: 520,
//             ),
//             viewPort:
//                 const CroppieViewPort(width: 480, height: 480, type: 'circle'),
//             enableExif: true,
//             enableZoom: true,
//             showZoomer: true,
//           ),
//         ],
//       );
//       if (croppedFile != null) {
//         setState(() {
//           _croppedFile = croppedFile;
//         });
//       }
//     }
//   }

//   Future<void> _uploadImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       // Calculate the desired area coordinates and size based on the image dimensions
//       double desiredLeft =
//           50; // Set the left position of the desired area (in pixels)
//       double desiredTop =
//           200; // Set the top position of the desired area (in pixels)
//       double desiredWidth =
//           200; // Set the width of the desired area (in pixels)
//       double desiredHeight =
//           200; // Set the height of the desired area (in pixels)
//       var decodedImage =
//           await decodeImageFromList(File(pickedFile.path).readAsBytesSync());
//       double imageWidth = decodedImage.width.toDouble();
//       double imageHeight = decodedImage.height.toDouble();
//       print(decodedImage.width);
//       print(decodedImage.height);

//       // Calculate the scale factor between the original image and the displayed image
//       double scaleX = imageWidth / imageWidth;
//       double scaleY = imageHeight / imageHeight;

//       // Calculate the desired area coordinates and size based on the scale factor
//       double scaledLeft = desiredLeft * scaleX;
//       double scaledTop = desiredTop * scaleY;
//       double scaledWidth = desiredWidth * scaleX;
//       double scaledHeight = desiredHeight * scaleY;
//       var cropSize = min(decodedImage.width, decodedImage.height);
//       int offsetX =
//           (decodedImage.width - min(decodedImage.width, decodedImage.height)) ~/
//               2;
//       int offsetY = (decodedImage.height -
//               min(decodedImage.width, decodedImage.height)) ~/
//           2;

//       final imageBytes =
//           img.decodeImage(File(pickedFile.path).readAsBytesSync())!;

//       img.Image cropOne = img.copyCrop(
//         imageBytes,
//         x: 1,
//         y: 1,
//         width: 2000,
//         height: 1000,
//       );
//       print(cropOne.height);
//       print(cropOne.width);

//       File temp =
//           await File(pickedFile.path).writeAsBytes(img.encodePng(cropOne));
//       setState(() {
//         _pickedFile = XFile(temp.path);
//       });
//     }
//   }

//   void _clear() {
//     setState(() {
//       _pickedFile = null;
//       _croppedFile = null;
//     });
//   }
// }
