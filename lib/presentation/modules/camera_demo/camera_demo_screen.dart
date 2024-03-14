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

import '../../../common/singletons.dart';
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
        title: (widget.task == MeasuringTask.bloodPressure)
            ? translation(context).cameraScreen
            : translation(context).resultScreen,
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
                return Stack(
                  children: [
                    Positioned(
                        top: SizeConfig.screenWidth * 0.02,
                        left: SizeConfig.screenWidth * 0.02,
                        child: CircleButton(
                          size: SizeConfig.screenDiagonal * 0.04,
                          iconData: Icons.arrow_back_outlined,
                          iconColor: AppColor.white,
                          backgroundColor: AppColor.appBarColor,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )),
                    const Center(
                        child: Loading(
                      loadingColor: AppColor.white,
                      brightness: Brightness.light,
                    ))
                  ],
                );
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
                              height: height * 0.65,
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
                        top: height * 0.55,
                        left: width * 0.15,
                        child: SizedBox(
                          width: SizeConfig.screenWidth * 0.7,
                          child: Center(
                            child: Text(translation(context).holdForFewSec,
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenWidth * 0.05,
                                    color: Colors.white)),
                          ),
                        ),
                      )
                    else
                      Positioned(
                        top: height * 0.07,
                        left: width * 0.2,
                        child: Container(
                          width: SizeConfig.screenWidth * 0.6,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(0, 59, 58, 58),
                          ),
                          child: Center(
                            child: Text(
                                (widget.task == MeasuringTask.bloodPressure)
                                    ? translation(context).cameraScreen
                                    : translation(context).resultScreen,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenWidth * 0.05,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    overlayRectangle(context, task: widget.task),
                    Stack(alignment: Alignment.topCenter, children: [
                      Positioned(
                          top: SizeConfig.screenWidth * 0.03,
                          left: SizeConfig.screenWidth * 0.03,
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
                            top: height * 0.55,
                            left: width * 0.15,
                            child: SizedBox(
                                width: SizeConfig.screenWidth * 0.7,
                                child: Center(
                                  child: Text(
                                      translation(context).holdForFewSec,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.05,
                                          color: Colors.white)),
                                )))
                      else
                        Positioned(
                          top: height * 0.07,
                          left: width * 0.2,
                          child: Container(
                            width: SizeConfig.screenWidth * 0.6,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                  (widget.task == MeasuringTask.bloodPressure)
                                      ? translation(context).cameraScreen
                                      : translation(context).resultScreen,
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.screenWidth * 0.05,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                    ]),
                    //cropStroke(context, task: widget.task),
                    Positioned(
                      top: height * 0.68,
                      left: width * 0.0825,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * 0.035,
                            width: SizeConfig.screenHeight * 0.035,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(Icons.sunny,
                                    size: SizeConfig.screenHeight * 0.025)),
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
                            width: SizeConfig.screenWidth * 0.1,
                            height: SizeConfig.screenHeight * 0.035,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.screenWidth * 0.015),
                            ),
                            child: Center(
                              child: Text(
                                '${currentExposureOffset.toStringAsFixed(1)}x',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.03),
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
                              if (state.status != BlocStatusState.loading) {
                                cameraBloc.add(GetImageEvent(
                                    task: widget.task,
                                    controller: controller!,
                                    context: context));
                              }

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
                            height: height * 0.045,
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
                                      size: height * 0.03,
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
                                      size: height * 0.03,
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

//! cropStroke ko sử dụng nữa
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
      left: MediaQuery.of(context).size.width * 0.2,
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
