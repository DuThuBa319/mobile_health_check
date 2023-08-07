import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../common_widget/enum_common.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
part 'camera_event.dart';
part 'camera_state.dart';

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitialState()) {
    on<GetImageEvent>(_onGetImage);
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
      croppedImage =
          await cropImage(context: event.context, pickedFile: imageFile);
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

Future<File> cropImage(
    {required File pickedFile, required BuildContext context}) async {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  // Calculate the desired area coordinates and size based on the image dimensions
  double desiredLeft =
      95; // Set the left position of the desired area (in pixels)
  double desiredTop =
      180; // Set the top position of the desired area (in pixels)
  double desiredWidth =
      screenWidth * 0.55; // Set the width of the desired area (in pixels)
  double desiredHeight =
      screenHeight * 0.40; // Set the height of the desired area (in pixels)
  var decodedImage =
      await decodeImageFromList(File(pickedFile.path).readAsBytesSync());
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
