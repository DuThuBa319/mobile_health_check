import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:flutter/material.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';

import '../../route/route_list.dart';
import 'ocr_scanner_bloc/ocr_scanner_bloc.dart';
part 'OCR_scanner_screen.action.dart';

class OCRScannerScreen extends StatefulWidget {
  final MeasuringTask task;
  const OCRScannerScreen({super.key, required this.task});

  @override
  State<OCRScannerScreen> createState() => _OCRScannerScreenState();
}

class _OCRScannerScreenState extends State<OCRScannerScreen> {
  String? message = "";

  OCRScannerBloc get scanBloc => BlocProvider.of(context);
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.task == MeasuringTask.temperature) {
          return CustomScreenForm(
            title: 'Thermometer',
            isShowAppBar: true,
            isShowLeadingButton: true,
            backgroundColor: Colors.white,
            appBarColor: Colors.blue,
            child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                        child: Loading(
                      brightness: Brightness.light,
                    ));
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Thermometer
                            // Text(
                            //   'Thermometer',
                            //   style: AppTextTheme.title2,
                            // ),
                            const SizedBox(height: 20),
                            imagePicker(state, context,
                                imageFile: state.viewModel.temperatureImageFile,
                                event:
                                    GetTemperatureDataEvent(context: context)),
                            const SizedBox(
                              height: 30,
                            ),
                            state.viewModel.temperatureImageFile != null
                                ? Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 75,
                                          width: 200,
                                          margin:
                                              const EdgeInsets.only(bottom: 28),
                                          padding: const EdgeInsets.fromLTRB(
                                              17, 10, 16, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColor.greyF3),
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Wrap(
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text('Nhiệt độ:'),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                        '${state.viewModel.temperature} °C'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            // const SizedBox(height: 30),
                            // const Center(
                            //     child: CommonButton(height: 70, title: 'Cập nhật'))
                          ]),
                    ),
                  );
                }),
          );
        }
        if (widget.task == MeasuringTask.bloodSugar) {
          return CustomScreenForm(
            title: 'Blood Glucose Meter',
            isShowAppBar: true,
            isShowLeadingButton: true,
            backgroundColor: Colors.white,
            appBarColor: Colors.blue,
            child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                        child: Loading(
                      brightness: Brightness.light,
                    ));
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Blood Glucose Meter
                            // Text(
                            //   'Blood Glucose Meter',
                            //   style: AppTextTheme.title2,
                            // ),
                            const SizedBox(height: 20),
                            imagePicker(state, context,
                                imageFile:
                                    state.viewModel.bloodGlucoseImageFile,
                                event:
                                    GetBloodGlucoseDataEvent(context: context)),
                            const SizedBox(
                              height: 30,
                            ),
                            state.viewModel.bloodGlucoseImageFile != null
                                ? Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 75,
                                          width: 300,
                                          margin:
                                              const EdgeInsets.only(bottom: 28),
                                          padding: const EdgeInsets.fromLTRB(
                                              17, 10, 16, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColor.greyF3),
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Wrap(
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text('Chỉ số đường huyết:'),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                        '${state.viewModel.glucose} mg/dL'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),

                            //const SizedBox(height: 30),
                            // const Center(
                            //     child: CommonButton(height: 70, title: 'Cập nhật'))
                          ]),
                    ),
                  );
                }),
          );
        }
        if (widget.task == MeasuringTask.bloodPressure) {
          return CustomScreenForm(
            title: 'Blood Pressure Meter',
            isShowAppBar: true,
            isShowLeadingButton: true,
            backgroundColor: Colors.white,
            appBarColor: Colors.blue,
            selectedIndex: 6,
            child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state is OCRScannerInitialState) {
                    scanBloc.add(GetInitialBloodPressureDataEvent());
                  }
                  if (state.status == BlocStatusState.loading) {
                    return const Center(
                        child: Loading(
                      brightness: Brightness.light,
                    ));
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Blood Pressure Meter
                            // Text(
                            //   'Blood Pressure Meter',
                            //   style: AppTextTheme.title2,
                            // ),
                            const SizedBox(height: 20),
                            imagePicker(state, context,
                                imageFile:
                                    state.viewModel.bloodPressureImageFile,
                                event: GetBloodPressureDataEvent(
                                    context: context)),
                            const SizedBox(
                              height: 30,
                            ),
                            state.viewModel.bloodPressureImageFile != null
                                ? Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 350,
                                          margin:
                                              const EdgeInsets.only(bottom: 28),
                                          padding: const EdgeInsets.fromLTRB(
                                              17, 10, 16, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColor.greyF3),
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Wrap(
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text('Huyết áp tâm thu:'),
                                                    Text(
                                                        'Huyết áp tâm trương:'),
                                                    Text('Nhịp tim:'),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                        '${state.viewModel.sys} mmHg'),
                                                    Text(
                                                        '${state.viewModel.dia} mmHg'),
                                                    Text(
                                                        '${state.viewModel.pulse} bpm'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 20),

                            const SizedBox(height: 30),
                            Center(
                                child: CommonButton(
                              height: 70,
                              title: 'Cập nhật',
                              onTap: () {
                                scanBloc.add(UploadBloodPressureDataEvent());
                              },
                            ))
                          ]),
                    ),
                  );
                }),
          );
        }
        return Container();
      },
    );
  }

  Widget imagePicker(OCRScannerState state, BuildContext context,
      {File? imageFile, required OCRScannerEvent event}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.blue)),
            child: imageFile == null
                ? IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                      size: 70,
                    ),
                    onPressed: () async {
                      scanBloc.add(event);
                    },
                  )
                : ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    child: FullScreenWidget(
                        disposeLevel: DisposeLevel.High,
                        child: Image.file(
                          File(imageFile.path),
                        )),
                  ),
          ),
        ),
        imageFile != null
            ? Positioned(
                bottom: -20,
                right: 40,
                child: InkWell(
                  onTap: () {
                    scanBloc.add(event);
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.autorenew_rounded,
                        size: 40,
                        color: Colors.blue,
                      )),
                ),
              )
            : Container(),
      ],
    );
  }
}
