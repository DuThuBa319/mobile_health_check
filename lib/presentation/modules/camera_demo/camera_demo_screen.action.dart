// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

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
      showExceptionDialog(
          context: context,
          message: translation(context).errorTryAgain,
          titleBtn: translation(context).exit,
          onClose: () {
            Navigator.pop(context);
          });
    }
    if (state is GetImageState && state.status == BlocStatusState.failure) {
      showExceptionDialog(
          context: context,
          message: translation(context).error,
          titleBtn: translation(context).exit,
          onClose: () {
            Navigator.pop(context);
          });
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller

    if (cameras.isNotEmpty) {
      cameraBloc.add(CameraInitializedEvent(
          controller: cameraController,
          context: context,
          task: widget.task,
          zoomValue: currentZoomLevel));
    } else {
      bool isCameraGranted = await Permission.camera.request().isGranted;
      if (!isCameraGranted) {
        checkPermission(context);
      } else {
        debugPrint("camera not available");
      }
    }
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
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
    return showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog.adaptive(
              iconPadding: EdgeInsets.zero,
              content: Container(
                height: SizeConfig.screenHeight * 0.53,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      translation(context).yourPhoto,
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.075,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: const Color.fromARGB(255, 60, 152, 198)),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FullScreenWidget(
                          disposeLevel: DisposeLevel.High,
                          child: Image.file(
                            File(imageFile.path),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.28,
                            height: SizeConfig.screenHeight * 0.053,
                            decoration: const BoxDecoration(
                                color: AppColor.graybebebe,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                translation(context).takePhotoAgain,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.035,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final CroppedImage croppedImage = CroppedImage(
                                imageFile,
                                currentFlashMode == FlashMode.off
                                    ? false
                                    : true);
                            controller!.dispose();
                            cameraBloc.add(CameraStoppedEvent(
                                controller: controller!,
                                context: context,
                                task: MeasuringTask.oximeter));
                            Navigator.pop(context);

                            Navigator.pop(context, croppedImage);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.28,
                            height: SizeConfig.screenHeight * 0.053,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 143, 217, 253),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                translation(context).accept,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
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
                  controller?.dispose();
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
  checkPermission(BuildContext context) async {
    try {
      bool isCameraGranted = await Permission.camera.request().isGranted;
      if (!isCameraGranted) {
        if (!isPopupPermissionShow) {
          isPopupPermissionShow = true;

          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return openSettingDialog(context);
              });
        }
        isPopupPermissionShow = false;
      }
    } catch (e) {
      debugPrint("camera error: $e");
    }
  }
}
