import 'dart:io';

import 'package:mobile_health_check/presentation/common_widget/dialog/exception_dialog.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobile_health_check/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../classes/language.dart';
import '../../../function.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../theme/theme_color.dart';
import 'camera_bloc/camera_bloc.dart';
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
    // TODO: implement initState
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active

      cameraBloc.add(CameraStoppedEvent(
          controller: controller!, context: context, task: widget.task));
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(controller!.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
        backgroundColor: backgroundColor,
        appBarColor: Colors.blue,
        isShowLeadingButton: true,
        isShowAppBar: true,
        title: translation(context).cameraScreen,
        selectedIndex: 4,
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
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                children: [
                  Positioned(
                      top: 0,
                      child: FittedBox(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.67,
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
                  state is GetImageState &&
                          state.status == BlocStatusState.loading
                      ? Positioned(
                          top: 80,
                          child: Text(translation(context).holdForFewSec,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        )
                      : Positioned(
                          top: 80,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text(translation(context).cameraScreen,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ),
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Colors.black54, BlendMode.srcOut),
                    child: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Stack(alignment: Alignment.topCenter, children: [
                          state is GetImageState &&
                                  state.status == BlocStatusState.loading
                              ? Positioned(
                                  top: 80,
                                  child: Text(
                                      translation(context).holdForFewSec,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                )
                              : Positioned(
                                  top: 80,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Text(
                                        translation(context).cameraScreen,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                ),
                          cropArea(context, task: widget.task)
                        ]),
                      ),
                    ]),
                  ),
                  cropStroke(context, task: widget.task),
                  // Positioned(
                  //   bottom: 280,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         child: const Padding(
                  //             padding: EdgeInsets.all(8.0),
                  //             child: Icon(Icons.zoom_in)),
                  //       ),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.70,
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Slider(
                  //           value: currentZoomLevel,
                  //           min: minAvailableZoom,
                  //           max: maxAvailableZoom,
                  //           activeColor: Colors.white,
                  //           inactiveColor: Colors.white30,
                  //           onChanged: (value) async {
                  //             setState(() {
                  //               currentZoomLevel = value;
                  //             });
                  //             await controller!.setZoomLevel(value);
                  //           },
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             '${currentZoomLevel.toStringAsFixed(1)}x',
                  //             style: const TextStyle(color: Colors.black),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Positioned(
                    bottom: 220,
                    child: Row(
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: const EdgeInsets.only(left: 20),
                          child: Slider(
                            value: currentExposureOffset,
                            min: minAvailableExposureOffset,
                            max: maxAvailableExposureOffset,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                            onChanged: (value) async {
                              // setState(() {
                              currentExposureOffset = value;
                              // });
                              // await controller!.setExposureOffset(value);
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
                            padding: const EdgeInsets.all(8.0),
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
                          child: const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.circle, color: Colors.white, size: 80),
                              Icon(Icons.circle, color: Colors.red, size: 65),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          color: Colors.blue,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
        ));
  }

  Widget cropStroke(BuildContext context, {required MeasuringTask task}) {
    if (task == MeasuringTask.bloodPressure) {
      return Positioned(
        top: 120,
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
        top: 150,
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
        top: 150,
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
      top: 200,
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

  Widget cropArea(BuildContext context, {required MeasuringTask task}) {
    if (task == MeasuringTask.bloodPressure) {
      return Positioned(
        top: 120,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.27,
            decoration: const BoxDecoration(
              color: Colors.black,
            )),
      );
    }
    if (task == MeasuringTask.bloodSugar) {
      return Positioned(
        top: 150,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: const BoxDecoration(
              color: Colors.black,
            )),
      );
    }
    if (task == MeasuringTask.oximeter) {
      return Positioned(
        top: 150,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.54,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              color: Colors.black,
            )),
      );
    }
    return Positioned(
      top: 200,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: const BoxDecoration(
            color: Colors.black,
          )),
    );
  }
}
