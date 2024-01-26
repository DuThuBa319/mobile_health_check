import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mobile_health_check/presentation/modules/camera_demo/overlay_with_rectangle_clipping_blood_sugar.dart';
import 'package:mobile_health_check/presentation/modules/camera_demo/overlay_with_rectangle_clipping_oxi.dart';
import 'package:mobile_health_check/presentation/modules/camera_demo/overlay_with_rectangle_clipping_temp.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../classes/language.dart';
import '../../../utils/size_config.dart';

import '../../common_widget/common.dart';
import '../../theme/theme_color.dart';
import 'camera_bloc/camera_bloc.dart';
import 'overlay_with_rectangle_clipping_blood_pressure.dart';
part 'camera_demo_screen.action.dart';

class CameraScreen extends StatefulWidget {
  final MeasuringTask task;
  const CameraScreen({super.key, this.task = MeasuringTask.bloodPressure});

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  Color backgroundColor = Colors.black;
  //! initialize
  CameraController? controller;

  bool isPopupPermissionShow = false;
  // bool isCameraInitialized = false;
  //* zoom
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 4.0;
  double currentZoomLevel = 1.0;

  //* exposure: độ sáng
  double minAvailableExposureOffset = -1.0;
  double maxAvailableExposureOffset = 1.0;
  double currentExposureOffset = 0.0;
  //* flash mode
  FlashMode? currentFlashMode = FlashMode.off;
  CameraBloc get cameraBloc => BlocProvider.of(context);

  @override
  void initState() {
    if (widget.task == MeasuringTask.bloodPressure) {
      currentZoomLevel = 1.7;
    }
    if (widget.task == MeasuringTask.bloodSugar) {
      currentZoomLevel = 2.0;
    }
    if (widget.task == MeasuringTask.temperature) {
      currentZoomLevel = 2;
    }
    if (widget.task == MeasuringTask.oximeter) {
      currentZoomLevel = 2.7;
    }
    WidgetsBinding.instance.addObserver(this);

    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      await controller?.dispose();
      // cameraBloc.add(CameraStoppedEvent(
      //     controller: controller!, context: context, task: widget.task));
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(controller!.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double height = SizeConfig.screenHeight;
    double width = SizeConfig.screenWidth;
    return CustomScreenForm(
        backgroundColor: backgroundColor,
        appBarColor: AppColor.appBarColor,
        isShowLeadingButton: true,
        isShowAppBar: false,
        title: translation(context).cameraScreen,
        leadingButton: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: SizeConfig.screenWidth * 0.1,
            color: Colors.white,
          ),
          onPressed: () {
            controller?.dispose();
            Navigator.pop(context);
          },
        ),
        selectedIndex: 4,
        child: PopScope(
          canPop: false,
          child: BlocConsumer<CameraBloc, CameraState>(
            listener: blocListener,
            builder: (context, state) {
              if (state is CameraReadyState &&
                  state.status == BlocStatusState.loading) {
                return const Center(
                    child: Loading(
                  brightness: Brightness.light,
                ));
              }
              if (state.status == BlocStatusState.failure) {
                return Center(
                  child: Text(
                    translation(context).error,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColor.red),
                  ),
                );
              }
              if ((state is CameraReadyState &&
                      state.status == BlocStatusState.success) ||
                  state is GetImageState) {
                backgroundColor = Colors.black;
                return Stack(
                  alignment: Alignment.topLeft,
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                        top: 0,
                        child: FittedBox(
                          child: SizedBox(
                              width: width,
                              height: height * 0.67,
                              child: CameraPreview(
                                state.viewModel.cameraController!,
                                child: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTapDown: (details) =>
                                        onViewFinderTap(details, constraints),
                                  );
                                }),
                              ) // this is my CameraPreview
                              ),
                        )),
                    if (state is GetImageState &&
                        state.status == BlocStatusState.loading)
                      Positioned(
                        top: height * 0.0877,
                        left: width * 0.315,
                        child: Text(translation(context).holdForFewSec,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      )
                    else
                      Positioned(
                        top: height * 0.0877,
                        left: width * 0.315,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Text(translation(context).cameraScreen,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    overlayRectangle(context, task: widget.task),
                    Stack(alignment: Alignment.topCenter, children: [
                      Positioned(
                          top: 15,
                          left: 15,
                          child: CircleButton(
                            size: SizeConfig.screenDiagonal * 0.04,
                            iconData: Icons.arrow_back_outlined,
                            iconColor: AppColor.white,
                            backgroundColor: AppColor.appBarColor,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )),
                      if (state is GetImageState &&
                          state.status == BlocStatusState.loading)
                        Positioned(
                          top: height * 0.0877,
                          left: width * 0.315,
                          child: Text(translation(context).holdForFewSec,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        )
                      else
                        Positioned(
                          top: height * 0.0877,
                          left: width * 0.315,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text(translation(context).cameraScreen,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ),
                    ]),
                    //cropStroke(context, task: widget.task),
                    Positioned(
                      bottom: height * 0.3,
                      left: width * 0.036,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.sunny),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.7,
                            child: Slider(
                              value: currentExposureOffset,
                              min: minAvailableExposureOffset,
                              max: maxAvailableExposureOffset,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white30,
                              onChanged: (value) async {
                                currentExposureOffset = value;

                                cameraBloc.add(
                                    CameraUpdateUiEvent(exposureValue: value));
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Text(
                                '${currentExposureOffset.toStringAsFixed(1)}x',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              cameraBloc.add(GetImageEvent(
                                  task: widget.task,
                                  controller: controller!,
                                  context: context));
                              // await imageDialog(context, imageFile: imageFile);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(Icons.circle,
                                    color: Colors.white,
                                    size: SizeConfig.screenDiagonal * 0.1),
                                Icon(Icons.circle,
                                    color: Colors.red,
                                    size: SizeConfig.screenDiagonal * 0.08),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.062,
                          ),
                          Container(
                            height: height * 0.06,
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            color: AppColor.appBarColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      currentFlashMode = FlashMode.off;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.off,
                                    );
                                  },
                                  child: SizedBox(
                                    width: width * 0.45,
                                    child: Icon(
                                      Icons.flash_off,
                                      color: currentFlashMode == FlashMode.off
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      currentFlashMode = FlashMode.torch;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.torch,
                                    );
                                  },
                                  child: SizedBox(
                                    width: width * 0.45,
                                    child: Icon(
                                      Icons.highlight,
                                      color: currentFlashMode == FlashMode.torch
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ));
  }

  Widget cropStroke(BuildContext context, {required MeasuringTask task}) {
    if (task == MeasuringTask.bloodPressure) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.144,
        left: MediaQuery.of(context).size.width * 0.23,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.height * 0.27,
          decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.white))),
        ),
      );
    }
    if (task == MeasuringTask.bloodSugar) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.179,
        left: MediaQuery.of(context).size.width * 0.105,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.white))),
        ),
      );
    }
    if (task == MeasuringTask.oximeter) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.179,
        left: MediaQuery.of(context).size.width * 0.23,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.54,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.white))),
        ),
      );
    }
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.23,
      left: MediaQuery.of(context).size.width * 0.20,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Colors.white))),
      ),
    );
  }

  Widget overlayRectangle(BuildContext context, {required MeasuringTask task}) {
    if (task == MeasuringTask.bloodPressure) {
      return const OverlayRectangleForBloodPressure();
    }
    if (task == MeasuringTask.bloodSugar) {
      return const OverlayRectangleForBloodSugar();
    }
    if (task == MeasuringTask.oximeter) {
      return const OverlayRectangleForOxi();
    }
    return const OverlayRectangleForTemperature();
  }
}
