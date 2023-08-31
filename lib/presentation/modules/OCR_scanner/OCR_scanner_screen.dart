import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:flutter/material.dart';
import '../../../function.dart';
import '../../common_widget/assets.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';

import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
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
            appComponentColor: Colors.black,
            backgroundColor: AppColor.blueD0F7FF,
            appBarColor: AppColor.blueD0F7FF,
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
                                ? temperatureCell(state)
                                : Center(
                                    child: Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.33),
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.black,
                                        height: 70,
                                        title: 'Upload',
                                        onTap: () {
                                          // scanBloc.add(UploadBloodPressureDataEvent());
                                        },
                                      ),
                                    ],
                                  )),
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
                                                    Text('Blood glucose:'),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                        '${state.viewModel.bloodSugarEntity?.bloodSugar} mg/dL'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        Center(
                                            child: CommonButton(
                                          height: 70,
                                          title: 'Upload',
                                          onTap: () {
                                            scanBloc.add(
                                                UploadBloodPressureDataEvent());
                                          },
                                        ))
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.33),
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.black,
                                        height: 70,
                                        title: 'Upload',
                                        onTap: () {
                                          // scanBloc.add(UploadBloodPressureDataEvent());
                                        },
                                      ),
                                    ],
                                  )),

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
            appComponentColor: Colors.black,
            backgroundColor: AppColor.blueD0F7FF,
            appBarColor: AppColor.blueD0F7FF,
            selectedIndex: 6,
            child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
                listener: blocListener,
                builder: (context, state) {
                  if (state is OCRScannerInitialState) {
                    // scanBloc.add(GetInitialBloodPressureDataEvent());
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
                                                    Text('Systolic:'),
                                                    Text('Diastolic:'),
                                                    Text('Pulse:'),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.vertical,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                        '${state.viewModel.bloodPressureEntity?.sys} mmHg'),
                                                    Text(
                                                        '${state.viewModel.bloodPressureEntity?.dia} mmHg'),
                                                    Text(
                                                        '${state.viewModel.bloodPressureEntity?.pulse} bpm'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        Center(
                                            child: CommonButton(
                                          height: 70,
                                          title: 'Upload',
                                          onTap: () {
                                            scanBloc.add(
                                                UploadBloodPressureDataEvent());
                                          },
                                        ))
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              SizeConfig.screenHeight * 0.33),
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.black,
                                        height: 70,
                                        title: 'Upload',
                                        onTap: () {
                                          // scanBloc.add(UploadBloodPressureDataEvent());
                                        },
                                      ),
                                    ],
                                  )),
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

  Center temperatureCell(OCRScannerState state) {
    return Center(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.24,
            width: SizeConfig.screenWidth * 0.8,
            margin: const EdgeInsets.only(bottom: 28),
            padding: const EdgeInsets.fromLTRB(17, 10, 16, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColor.greyF3),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[100],
                        ),
                        child: Image.asset(
                          Assets.thermometer,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text('CHỈ SỐ ĐO',
                                style: AppTextTheme.title3.copyWith(
                                    color: Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.05,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat('HH:mm dd/MM/yyyy').format(state
                                    .viewModel.temperatureEntity!.updatedDate!),
                                style: AppTextTheme.title3.copyWith(
                                    color: AppColor.gray767676,
                                    fontSize: SizeConfig.screenWidth * 0.035,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Thân nhiệt:',
                      style: AppTextTheme.title3.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, left: SizeConfig.screenWidth * 0.1),
                    width: SizeConfig.screenWidth * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${state.viewModel.temperatureEntity?.temperature}",
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "°",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "C",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500))
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Center(
              child: CommonButton(
            height: 70,
            title: 'Upload',
            onTap: () {
              scanBloc.add(UploadTemperatureDataEvent());
            },
          ))
        ],
      ),
    );
  }

  Widget imagePicker(OCRScannerState state, BuildContext context,
      {File? imageFile, required OCRScannerEvent event}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Material(
            elevation: 10,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: SizeConfig.screenWidth * 0.75,
              width: SizeConfig.screenWidth * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: imageFile == null
                  ? GestureDetector(
                      onTap: () async {
                        scanBloc.add(event);
                      },
                      child: Image.asset(Assets.icCameraAdd),
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
