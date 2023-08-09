import 'dart:io';

import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobile_health_check/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import 'camera_bloc/camera_bloc.dart';
part 'camera_demo_screen.action.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  Color backgroundColor = Colors.white;
  //! initialize
  CameraController? controller;
  bool isCameraInitialized = false;
  //* zoom
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  double currentZoomLevel = 1.0;
  //* exposure: độ sáng
  double minAvailableExposureOffset = 0.0;
  double maxAvailableExposureOffset = 0.0;
  double currentExposureOffset = 0.0;
  CameraBloc get cameraBloc => BlocProvider.of(context);
  //* flash mode
  FlashMode? currentFlashMode = FlashMode.off;
  @override
  void initState() {
    // TODO: implement initState
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
      isCameraInitialized = false;
      controller!.dispose();
      setState(() {});
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(controller!.description);
    }
    setState(() {
      // _appLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
        backgroundColor: backgroundColor,
        appBarColor: Colors.blue,
        isShowLeadingButton: true,
        isShowAppBar: true,
        title: 'Camera Screen',
        selectedIndex: 4,
        child: BlocConsumer<CameraBloc, CameraState>(
          listener: blocListener,
          builder: (context, state) {
            // if (state is GetImageState &&
            //     state.status == BlocStatusState.loading) {
            //   backgroundColor = Colors.white;
            //   return const Center(
            //       child: Loading(
            //     brightness: Brightness.light,
            //   ));
            // }
            return isCameraInitialized
                ? Stack(
                    alignment: Alignment.topCenter,
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                          top: 0,
                          child: FittedBox(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.67,
                                child: CameraPreview(
                                  controller!,
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
                          ? const Positioned(
                              top: 80,
                              child: Text('Giữ ví trí trong vài giây',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )
                          : Container(),
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.black54, BlendMode.srcOut),
                        child: Stack(children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    top: 120,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        )),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                      Positioned(
                        top: 120,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.height * 0.27,
                          decoration: const ShapeDecoration(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2, color: Colors.white))),
                        ),
                      ),
                      Positioned(
                        bottom: 160,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.83,
                              padding: const EdgeInsets.only(left: 20),
                              child: Slider(
                                value: currentZoomLevel,
                                min: minAvailableZoom,
                                max: maxAvailableZoom,
                                activeColor: Colors.white,
                                inactiveColor: Colors.white30,
                                onChanged: (value) async {
                                  setState(() {
                                    currentZoomLevel = value;
                                  });
                                  await controller!.setZoomLevel(value);
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${currentZoomLevel.toStringAsFixed(1)}x',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 120,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.83,
                              padding: const EdgeInsets.only(left: 20),
                              child: Slider(
                                value: currentExposureOffset,
                                min: minAvailableExposureOffset,
                                max: maxAvailableExposureOffset,
                                activeColor: Colors.white,
                                inactiveColor: Colors.white30,
                                onChanged: (value) async {
                                  setState(() {
                                    currentExposureOffset = value;
                                  });
                                  await controller!.setExposureOffset(value);
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${currentExposureOffset.toStringAsFixed(1)}x',
                                  style: const TextStyle(color: Colors.white),
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
                                    controller: controller!, context: context));
                                // await imageDialog(context, imageFile: imageFile);
                              },
                              child: const Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.circle,
                                      color: Colors.white, size: 80),
                                  Icon(Icons.circle,
                                      color: Colors.red, size: 65),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    child: Icon(
                                      Icons.flash_off,
                                      color: currentFlashMode == FlashMode.off
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        currentFlashMode = FlashMode.auto;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.auto,
                                      );
                                    },
                                    child: Icon(
                                      Icons.flash_auto,
                                      color: currentFlashMode == FlashMode.auto
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        currentFlashMode = FlashMode.always;
                                      });
                                      await controller!.setFlashMode(
                                        FlashMode.always,
                                      );
                                    },
                                    child: Icon(
                                      Icons.flash_on,
                                      color:
                                          currentFlashMode == FlashMode.always
                                              ? Colors.amber
                                              : Colors.white,
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
                                    child: Icon(
                                      Icons.highlight,
                                      color: currentFlashMode == FlashMode.torch
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: Loading(
                    brightness: Brightness.light,
                  ));
          },
        ));
  }
}
