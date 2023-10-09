// ignore_for_file: invalid_use_of_protected_member

part of 'camera_demo_screen.dart';

// HẠN CHẾ SETSTATE NHẤT CÓ THỂ, PHẢI THỂ HIỆN ĐƯỢC CÁI STRING
extension CameraScreenAction on CameraScreenState {
  void blocListener(BuildContext context, CameraState state) async {
    if (state is GetImageState && state.status == BlocStatusState.loading) {
      showToast(translation(context).processing);
    }
    if (state is GetImageState && state.status == BlocStatusState.success) {
      showToast(translation(context).processSuccessfully);
      await imageDialog(context, imageFile: state.viewModel.imageFile!);
    }
    if (state is CameraReadyState && state.status == BlocStatusState.loading) {
      showToast(translation(context).processing);
    }
    if (state is CameraReadyState && state.status == BlocStatusState.success) {
      showToast(translation(context).processSuccessfully);
    }
    if (state is CameraReadyState && state.status == BlocStatusState.failure) {
      // ignore: use_build_context_synchronously
      showNoticeDialog(
          context: context,
          message: translation(context).errorTryAgain,
          title: translation(context).notification,
          titleBtn: translation(context).exit,
          onClose: () {
            Navigator.pop(context);
          });
    }
    if (state is GetImageState && state.status == BlocStatusState.failure) {
      // ignore: use_build_context_synchronously
      showNoticeDialog(
          context: context,
          message: translation(context).error,
          title: translation(context).notification,
          titleBtn: translation(context).exit,
          onClose: () {
            Navigator.pop(context);
          });
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      controller = cameraController;
      cameraBloc.add(CameraInitializedEvent(
          controller: cameraController,
          context: context,
          task: widget.task,
          zoomValue: currentZoomLevel));
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) {
        //cameraBloc.add(CameraUpdateUiEvent());
      }
    });

    // Initialize controller
    // try {
    //   await controller!.initialize();
    // } on CameraException catch (e) {
    //   debugPrint('Error initializing camera: $e');
    // }

    // Update the Boolean
    // if (mounted) {
    //   await controller!.setFlashMode(
    //     FlashMode.off,
    //   );
    //   setState(() {
    //     isCameraInitialized = controller!.value.isInitialized;
    //     backgroundColor = Colors.black;
    //   });
    // }

    // cameraController.getMaxZoomLevel().then((value) => maxAvailableZoom = 4);

    // cameraController
    //     .getMinZoomLevel()
    //     .then((value) => minAvailableZoom = value);
    // cameraController.setZoomLevel(currentZoomLevel);
    // cameraController
    //     .getMinExposureOffset()
    //     .then((value) => minAvailableExposureOffset = value);

    // cameraController
    //     .getMaxExposureOffset()
    //     .then((value) => maxAvailableExposureOffset = value);
    // currentFlashMode = controller!.value.flashMode;
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  Future<dynamic> imageDialog(BuildContext context, {required File imageFile}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(translation(context).yourPhoto),
              content: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  child: FullScreenWidget(
                      disposeLevel: DisposeLevel.High,
                      child: Image.file(
                        File(imageFile.path),
                      )),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(translation(context).takePhotoAgain)),
                const SizedBox(width: 10),
                TextButton(
                    onPressed: () {
                      final CroppedImage croppedImage = CroppedImage(imageFile,
                          currentFlashMode == FlashMode.off ? false : true);
                      controller!.dispose();
                      cameraBloc.add(CameraStoppedEvent(
                          controller: controller!,
                          context: context,
                          task: MeasuringTask.oximeter));
                      Navigator.pop(context);

                      Navigator.pop(context, croppedImage);
                    },
                    child: Text(translation(context).accept))
              ],
            ));
  }
}
