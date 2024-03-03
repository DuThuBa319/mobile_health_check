// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../common_widget/common.dart';
import '../../../common_widget/enum_common.dart';

part 'camera_event.dart';
part 'camera_state.dart';

bool isPopupPermissionShow = false;

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitialState()) {
    on<CameraInitializedEvent>(_onInitializeCamera);
    on<CameraStoppedEvent>(_onStopCamera);
    on<GetImageEvent>(_onGetImage);
    on<CameraUpdateUiEvent>(_onRefreshScreen);
  }
  Future<void> _onRefreshScreen(
    CameraUpdateUiEvent event,
    Emitter<CameraState> emit,
  ) async {
    await state.viewModel.cameraController!
        .setExposureOffset(event.exposureValue!);
    emit(
      CameraReadyState(
        status: BlocStatusState.success,
        viewModel: state.viewModel,
      ),
    );
  }

  Future<void> _onStopCamera(
    CameraStoppedEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(
      CameraStoppedState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await event.controller.dispose();

      emit(
        state.copyWith(
            status: BlocStatusState.success,
            viewModel:
                state.viewModel.copyWith(cameraController: event.controller)),
      );
    } on CameraException {
      event.controller.dispose();
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
        ),
      );
    } catch (e) {
      state.copyWith(
        status: BlocStatusState.failure,
      );
    }
  }

  Future<void> _onInitializeCamera(
    CameraInitializedEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(
      CameraReadyState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      Future.delayed(const Duration(seconds: 5)).whenComplete(() {
        if (state.status == BlocStatusState.loading) {
          emit(
            state.copyWith(
              status: BlocStatusState.failure,
            ),
          );
        }
      });
      final controller = event.controller;
      try {
        await controller.initialize();
        await controller.setZoomLevel(event.zoomValue);
        await controller.setFlashMode(
          FlashMode.off,
        );
        final newViewModel =
            state.viewModel.copyWith(cameraController: controller);
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        await [
          // Request camera and microphone permissions
          Permission.camera,
          Permission.microphone,
        ].request();
        if (await Permission.camera.status != PermissionStatus.granted ||
            await Permission.microphone.status != PermissionStatus.granted) {
          await showWarningDialog(
              context: navigationService.navigatorKey.currentContext!,
              message:
                  translation(navigationService.navigatorKey.currentContext!)
                      .permissionWarning,
              onClose1: () {},
              onClose2: () async {
                await openAppSettings();
              });
        } else {
          debugPrint("camera error $e");
        }
      }
    } on CameraException {
      event.controller.dispose();
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
        ),
      );
    } catch (e) {
      state.copyWith(
        status: BlocStatusState.failure,
      );
    }
  }

  Future<void> _onGetImage(
    GetImageEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(
      GetImageState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      File? croppedImage;
      File? imageFile = await pickImage(controller: event.controller);
      croppedImage = await cropImage(
          context: event.context, pickedFile: imageFile, task: event.task);
      final newViewModel = state.viewModel.copyWith(imageFile: croppedImage);
      emit(
        state.copyWith(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}

Future<File> pickImage({required CameraController controller}) async {
  XFile? rawImage = await takePicture(controller: controller);
  File imageFile = File(rawImage!.path);

  int currentUnix = DateTime.now().millisecondsSinceEpoch;
  final directory = await getApplicationDocumentsDirectory();
  String fileFormat = imageFile.path.split('.').last;

  File imagefile = await imageFile.copy(
    '${directory.path}/$currentUnix.$fileFormat',
  );
  return imagefile;
}

Future<XFile?> takePicture({required CameraController controller}) async {
  final CameraController cameraController = controller;
  if (cameraController.value.isTakingPicture) {
    // A capture is already pending, do nothing.
    return null;
  }
  try {
    XFile file = await cameraController.takePicture();
    return file;
  } on CameraException catch (e) {
    debugPrint('Error occured while taking picture: $e');
    return null;
  }
}

//
Future<File> cropImage(
    {required File pickedFile,
    required BuildContext context,
    required MeasuringTask task}) async {
  print(
      "######${userDataData.localDataManager.preferencesHelper.getData('BloodPressureEquipModel')}");
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  List<double> sizeFrame = [
    screenWidth * 0.25,
    screenHeight * 0.15,
    screenWidth * 0.55,
    screenHeight * 0.28,
    0
  ];
  //? sizeFrame[0]: left
  //? sizeFrame[1]: top
  //? sizeFrame[2]: width
  //? sizeFrame[3]: height
  //? sizeFrame[4]: radius
  //? initial => BP1

  double desiredLeft = 0, desiredTop = 0, desiredWidth = 0, desiredHeight = 0;
  switch (task) {
    case MeasuringTask.bloodPressure:
      switch (userDataData.localDataManager.preferencesHelper
          .getData('BloodPressureEquipModel')) {
        case 0:
          sizeFrame[0] = screenWidth * 0.25;
          sizeFrame[1] = screenHeight * 0.1985;
          sizeFrame[2] = screenWidth * 0.64;
          sizeFrame[3] = screenHeight * 0.46;
          break;
        case 1:
          sizeFrame[0] = screenWidth * 0.25;
          sizeFrame[1] = screenHeight * 0.15;
          sizeFrame[2] = screenWidth * 0.55;
          sizeFrame[3] = screenHeight * 0.28;
          break;
        case 2:
          sizeFrame[0] = screenWidth * 0.175;
          sizeFrame[1] = screenHeight * 0.1985;
          sizeFrame[2] = screenWidth * 0.82;
          sizeFrame[3] = screenHeight * 0.5;
          break;
        case 3:
          sizeFrame[0] = screenWidth * 0.165;
          sizeFrame[1] = screenHeight * 0.19;
          sizeFrame[2] = screenWidth * 0.77;
          sizeFrame[3] = screenHeight * 0.48;
          break;
      }

      desiredLeft =
          sizeFrame[0]; // Set the left position of the desired area (in pixels)
      desiredTop =
          sizeFrame[1]; // Set the top position of the desired area (in pixels)
      desiredWidth =
          sizeFrame[2]; // Set the width of the desired area (in pixels)
      desiredHeight = sizeFrame[3];

      break;
    case MeasuringTask.bloodSugar:
      switch (userDataData.localDataManager.preferencesHelper
          .getData('BloodSugarEquipModel')) {
        case 0:
          sizeFrame[0] = screenWidth * 1 / 12;
          sizeFrame[1] = screenHeight * 0.248;
          sizeFrame[2] = screenWidth * 0.6;
          sizeFrame[3] = screenHeight * 0.28;
          break;

        case 1:
          sizeFrame[0] = screenWidth * 1 / 12;
          sizeFrame[1] = screenHeight * 0.248;
          sizeFrame[2] = screenWidth * 0.78;
          sizeFrame[3] = screenHeight * 0.35;
          break;
      }
      desiredLeft =
          sizeFrame[0]; // Set the left position of the desired area (in pixels)
      desiredTop =
          sizeFrame[1]; // Set the top position of the desired area (in pixels)
      desiredWidth =
          sizeFrame[2]; // Set the width of the desired area (in pixels)
      desiredHeight = sizeFrame[3];
      break;
    case MeasuringTask.oximeter:
      desiredLeft = 80; // Set the left position of the desired area (in pixels)
      desiredTop = 210; // Set the top position of the desired area (in pixels)
      desiredWidth =
          screenWidth * 0.6; // Set the width of the desired area (in pixels)
      desiredHeight = screenHeight * 0.28;
      break;
    case MeasuringTask.temperature:
      switch (userDataData.localDataManager.preferencesHelper
          .getData('TempEquipModel')) {
        case 0:
          sizeFrame[0] = screenWidth * 0.25;
          sizeFrame[1] = screenHeight * 0.15;
          sizeFrame[2] = screenWidth * 0.55;
          sizeFrame[3] = screenHeight * 0.28;
          sizeFrame[4] = 0;
          break;
        case 1:
          sizeFrame[0] = screenWidth * 0.25;
          sizeFrame[1] = screenHeight * 0.15;
          sizeFrame[2] = screenWidth * 0.55;
          sizeFrame[3] = screenHeight * 0.28;
          sizeFrame[4] = 0;
          break;
        case 2:
          sizeFrame[0] = screenWidth * 0.155;
          sizeFrame[1] = screenHeight * 0.16;
          sizeFrame[2] = screenWidth * 0.75;
          sizeFrame[3] = screenHeight * 0.3;
          sizeFrame[4] = 40;
          break;
      }
      desiredLeft = 60; // Set the left position of the desired area (in pixels)
      desiredTop = 300; // Set the top position of the desired area (in pixels)
      desiredWidth =
          screenWidth * 0.65; // Set the width of the desired area (in pixels)
      desiredHeight = screenHeight * 0.18;
      break;
    default:
      break;
  }

  // Calculate the desired area coordinates and size based on the image dimensions
  // Set the height of the desired area (in pixels)
  var decodedImage =
      await decodeImageFromList(File(pickedFile.path).readAsBytesSync());
  print("####${decodedImage.width}");
  double imageWidth = decodedImage.width.toDouble();
  double imageHeight = decodedImage.height.toDouble();
  debugPrint('${decodedImage.width}');
  debugPrint('${decodedImage.height}');

  // Calculate the scale factor between the original image and the displayed image
  double scaleX = imageWidth / screenWidth;
  double scaleY = imageHeight / screenHeight;

  // Calculate the desired area coordinates and size based on the scale factor
  double scaledLeft = desiredLeft * scaleX;
  double scaledTop = desiredTop * scaleY;
  double scaledWidth = desiredWidth * scaleX;
  double scaledHeight = desiredHeight * scaleY;

  final imageBytes = img.decodeImage(File(pickedFile.path).readAsBytesSync())!;

  img.Image cropOne = img.copyCrop(
    imageBytes,
    x: scaledLeft.toInt(),
    y: scaledTop.toInt(),
    width: scaledWidth.toInt(),
    height: scaledHeight.toInt(),
  );
  debugPrint('${cropOne.height}');
  debugPrint('${cropOne.width}');

  File temp = await File(pickedFile.path).writeAsBytes(img.encodePng(cropOne));
  return temp;
}

openSettingDialog(BuildContext context) => AlertDialog(
      title: const Text("Camera permission not granted"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              child: const Text("Open Setting"),
              onTap: () async {
                Navigator.pop(context, null);

                await openAppSettings();
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              child: const Text("Cancel"),
              onTap: () async {
                Navigator.pop(context, null);
                return;
              },
            ),
          ],
        ),
      ),
    );
