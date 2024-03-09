// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

part of 'camera_demo_screen.dart';

// HẠN CHẾ SETSTATE NHẤT CÓ THỂ, PHẢI THỂ HIỆN ĐƯỢC CÁI STRING
extension CameraScreenAction on CameraScreenState {
  void blocListener(BuildContext context, CameraState state) async {
    if (state is GetImageState && state.status == BlocStatusState.loading) {
      showToast(
          context: context,
          status: ToastStatus.loading,
          toastString: translation(context).processing);
    }
    if (state is GetImageState && state.status == BlocStatusState.success) {
      showToast(
          context: context,
          status: ToastStatus.success,
          toastString: translation(context).processSuccessfully);
      await imageDialog(context, imageFile: state.viewModel.imageFile!);
    }
    if (state is CameraReadyState && state.status == BlocStatusState.loading) {
      showToast(
          context: context,
          status: ToastStatus.loading,
          toastString: translation(context).processing);
    }
    if (state is CameraReadyState && state.status == BlocStatusState.success) {
      showToast(
          context: context,
          status: ToastStatus.success,
          toastString: translation(context).processSuccessfully);
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
      if (await Permission.camera.status != PermissionStatus.granted ||
          await Permission.microphone.status != PermissionStatus.granted) {
        await showWarningDialog(
            context: navigationService.navigatorKey.currentContext!,
            message: translation(navigationService.navigatorKey.currentContext!)
                .permissionCameraWarning,
            onClose1: () {},
            onClose2: () async {
              await openAppSettings();
            });
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
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              iconPadding: EdgeInsets.zero,
              content: Container(
                height: (widget.task != MeasuringTask.bloodSugar)
                    ? SizeConfig.screenHeight * 0.53
                    : SizeConfig.screenHeight * 0.65,
                width: (widget.task != MeasuringTask.bloodSugar)
                    ? SizeConfig.screenWidth * 0.85
                    : SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 0.01),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.035),
                      child: FullScreenWidget(
                          disposeLevel: DisposeLevel.Medium,
                          child: Image.file(
                            height: SizeConfig.screenHeight * 0.3,
                            fit: BoxFit.fitWidth,
                            File(imageFile.path),
                          )),
                    ),
                    (widget.task == MeasuringTask.bloodSugar)
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.45,
                                      height: SizeConfig.screenHeight * 0.1,
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Nếu kết quả đo là",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.045
                                                    : SizeConfig.screenWidth *
                                                        0.04,
                                                color: AppColor.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " Lo",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: AppColor.blue0089D7,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " thì nhấn vào nút sau",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.045
                                                    : SizeConfig.screenWidth *
                                                        0.04,
                                                color: AppColor.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        userDataData
                                            .localDataManager.preferencesHelper
                                            .saveData("Indicator", 20);
                                        showToast(
                                            status: ToastStatus.success,
                                            context: context,
                                            toastString:
                                                "Lưu kết quả thành công");
                                        final CroppedImage croppedImage =
                                            CroppedImage(
                                                imageFile,
                                                currentFlashMode ==
                                                        FlashMode.off
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
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.03
                                                    : SizeConfig.screenWidth *
                                                        0.01)),
                                            color: AppColor.blue0089D7),
                                        height: SizeConfig.screenHeight * 0.05,
                                        width: SizeConfig.screenWidth * 0.16,
                                        child: Center(
                                            child: Text(
                                          "LOW",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.white,
                                              fontSize: SizeConfig.screenWidth *
                                                  0.04),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.45,
                                      height: SizeConfig.screenHeight * 0.1,
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Nếu kết quả đo là",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.045
                                                    : SizeConfig.screenWidth *
                                                        0.04,
                                                color: AppColor.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " Hi",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: AppColor.redFB4B53,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " thì nhấn vào nút sau",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.045
                                                    : SizeConfig.screenWidth *
                                                        0.04,
                                                color: AppColor.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        userDataData
                                            .localDataManager.preferencesHelper
                                            .saveData("Indicator", 600);
                                        showToast(
                                            status: ToastStatus.success,
                                            context: context,
                                            toastString:
                                                "Lưu kết quả thành công");

                                        final CroppedImage croppedImage =
                                            CroppedImage(
                                                imageFile,
                                                currentFlashMode ==
                                                        FlashMode.off
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
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(SizeConfig
                                                            .screenDiagonal <
                                                        1350
                                                    ? SizeConfig.screenWidth *
                                                        0.03
                                                    : SizeConfig.screenWidth *
                                                        0.01)),
                                            color: AppColor.redFB4B53),
                                        height: SizeConfig.screenHeight * 0.05,
                                        width: SizeConfig.screenWidth * 0.16,
                                        child: Center(
                                            child: Text(
                                          "HIGH",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.white,
                                              fontSize: SizeConfig.screenWidth *
                                                  0.04),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
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
                                    fontSize: SizeConfig.screenDiagonal < 1350
                                        ? SizeConfig.screenWidth * 0.04
                                        : SizeConfig.screenWidth * 0.028,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.02,
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
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 143, 217, 253),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    SizeConfig.screenWidth * 0.01))),
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
}
