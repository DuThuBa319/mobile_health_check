import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form_for_patient.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../classes/language_constant.dart';
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
  TextEditingController editSys = TextEditingController();
  TextEditingController editDia = TextEditingController();
  TextEditingController editPul = TextEditingController();

  TextEditingController editBloogSugarController = TextEditingController();
  TextEditingController editBodyTemperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.task == MeasuringTask.temperature) {
          return PatientCustomScreenForm(
            title: translation(context).thermometer,
            isShowAppBar: true,
            isShowLeadingButton: true,
            appComponentColor: Colors.white,
            backgroundColor: AppColor.blueD0F7FF,
            appBarColor: AppColor.topGradient,
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
                      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Thermometer
                            // Text(
                            //   translation(context).thermometer,
                            //   style: AppTextTheme.title2,
                            // ),
                            SizedBox(height: SizeConfig.screenWidth * 0.15),
                            imagePicker(state, context,
                                imageFile: state.viewModel.temperatureImageFile,
                                event:
                                    GetTemperatureDataEvent(context: context)),
                            SizedBox(
                              height: SizeConfig.screenWidth * 0.08,
                            ),
                            state.viewModel.temperatureImageFile != null
                                ? temperatureCell(state)
                                : Center(
                                    child: Column(
                                    children: [
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.white,
                                        height: SizeConfig.screenWidth * 0.18,
                                        width: SizeConfig.screenWidth * 0.8,
                                        title: translation(context).upload,
                                        onTap: () {
                                          // scanBloc.add(
                                          //     UploadBloodPressureDataEvent());
                                        },
                                      ),
                                    ],
                                  )),
                            // const SizedBox(height: SizeConfig.screenWidth*0.08),
                            // const Center(
                            //     child: CommonButton(height: SizeConfig.screenWidth*0.18, title: 'Cập nhật'))
                          ]),
                    ),
                  );
                }),
          );
        }
        if (widget.task == MeasuringTask.bloodSugar) {
          return PatientCustomScreenForm(
            title: translation(context).bloodGlucoseMeter,
            isShowAppBar: true,
            isShowLeadingButton: true,
            appComponentColor: Colors.white,
            backgroundColor: AppColor.blueD0F7FF,
            appBarColor: AppColor.topGradient,
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
                      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Blood Glucose Meter
                            // Text(
                            //   'Blood Glucose Meter',
                            //   style: AppTextTheme.title2,
                            // ),
                            SizedBox(height: SizeConfig.screenWidth * 0.15),
                            imagePicker(state, context,
                                imageFile:
                                    state.viewModel.bloodGlucoseImageFile,
                                event:
                                    GetBloodGlucoseDataEvent(context: context)),
                            SizedBox(
                              height: SizeConfig.screenWidth * 0.08,
                            ),
                            state.viewModel.bloodGlucoseImageFile != null
                                ? bloodGlucoseCell(state)
                                : Center(
                                    child: Column(
                                    children: [
                                      // SizedBox(
                                      //     height:
                                      //         SizeConfig.screenHeight * 0.33),
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.white,
                                        height: SizeConfig.screenWidth * 0.18,
                                        width: SizeConfig.screenWidth * 0.8,
                                        title: translation(context).upload,
                                        onTap: () {
                                          // scanBloc.add(
                                          //     UploadBloodPressureDataEvent());
                                        },
                                      ),
                                    ],
                                  )),

                            //const SizedBox(height: SizeConfig.screenWidth*0.08),
                            // const Center(
                            //     child: CommonButton(height: SizeConfig.screenWidth*0.18, title: 'Cập nhật'))
                          ]),
                    ),
                  );
                }),
          );
        }
        if (widget.task == MeasuringTask.bloodPressure) {
          return PatientCustomScreenForm(
            title: translation(context).bloodPressureMeter,
            isShowAppBar: true,
            isShowLeadingButton: true,
            appComponentColor: Colors.white,
            backgroundColor: AppColor.blueD0F7FF,
            appBarColor: AppColor.topGradient,
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
                      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Blood Pressure Meter
                            // Text(
                            //   translation(context).bloodPressureMeter,
                            //   style: AppTextTheme.title2,
                            // ),
                            SizedBox(height: SizeConfig.screenWidth * 0.15),
                            imagePicker(state, context,
                                imageFile:
                                    state.viewModel.bloodPressureImageFile,
                                event: GetBloodPressureDataEvent(
                                    context: context)),
                            SizedBox(
                              height: SizeConfig.screenWidth * 0.08,
                            ),
                            state.viewModel.bloodPressureImageFile != null
                                ? bloodPressureCell(state)
                                : Center(
                                    child: Column(
                                    children: [
                                      // SizedBox(
                                      //     height:
                                      //         SizeConfig.screenHeight * 0.33),
                                      CommonButton(
                                        buttonColor: AppColor.greyD9,
                                        textColor: Colors.white,
                                        height: SizeConfig.screenWidth * 0.18,
                                        width: SizeConfig.screenWidth * 0.8,
                                        title: translation(context).upload,
                                        onTap: () {
                                          // scanBloc.add(
                                          //     UploadBloodPressureDataEvent());
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

  Widget temperatureCell(OCRScannerState state) {
    return Center(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.24,
            width: SizeConfig.screenWidth * 0.8,
            margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.04,
                SizeConfig.screenWidth * 0.03,
                SizeConfig.screenWidth * 0.04,
                0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.05),
                color: AppColor.white),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth * 0.04,
                fontWeight: FontWeight.w400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.05),
                          color: AppColor.bodyTemperatureColor,
                        ),
                        child: Image.asset(
                          Assets.temperature,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(translation(context).bodyTemperature,
                                      style: AppTextTheme.title3.copyWith(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.045,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('HH:mm dd/MM/yyyy').format(
                                          state.viewModel.temperatureEntity!
                                              .updatedDate!),
                                      style: AppTextTheme.title3.copyWith(
                                          color: AppColor.gray767676,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.035,
                                          fontWeight: FontWeight.bold))
                                ]),
                            GestureDetector(
                                child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.075,
                                    height: SizeConfig.screenWidth * 0.075,
                                    child: Image.asset(Assets.edit)),
                                onTap: () {
                                  showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        editBodyTemperatureController.text =
                                            "${state.viewModel.temperatureEntity?.temperature}";
                                        return AlertDialog(
                                          title: Text(translation(context)
                                              .editIndicatore),
                                          content: Container(
                                            margin: EdgeInsets.only(
                                                bottom: SizeConfig.screenWidth *
                                                    0.025),
                                            padding: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.025),
                                            height:
                                                SizeConfig.screenWidth * 0.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  AppColor.cardBackgroundColor,
                                            ),
                                            child: TextField(
                                              controller:
                                                  editBodyTemperatureController,
                                              style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: translation(context)
                                                    .bodyTemperature,
                                                labelStyle: TextStyle(
                                                    color: AppColor.gray767676,
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    translation(context).back)),
                                            TextButton(
                                              child: Text(
                                                  translation(context).save),
                                              onPressed: () {
                                                double? editedTemperature =
                                                    double.parse(
                                                        editBodyTemperatureController
                                                            .text);

                                                setState(() {});
                                                scanBloc.add(
                                                    EditBodyTemperatureDataEvent(
                                                        context: context,
                                                        temperature:
                                                            editedTemperature));

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.03),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                    width: SizeConfig.screenWidth * 0.5,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "${state.viewModel.temperatureEntity?.temperature}",
                              style: AppTextTheme.title3.copyWith(
                                  color: state
                                      .viewModel.temperatureEntity?.statusColor,
                                  fontSize: SizeConfig.screenWidth * 0.15,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "°",
                              style: AppTextTheme.title3.copyWith(
                                  color: const Color(0xff615A5A),
                                  fontSize: SizeConfig.screenWidth * 0.15,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "C",
                              style: AppTextTheme.title3.copyWith(
                                  color: const Color(0xff615A5A),
                                  fontSize: SizeConfig.screenWidth * 0.1,
                                  fontWeight: FontWeight.w500))
                        ])),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
              child: CommonButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadTemperatureDataEvent());
            },
          ))
        ],
      ),
    );
  }

  Widget bloodPressureCell(OCRScannerState state) {
    return Center(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.24,
            width: SizeConfig.screenWidth * 0.8,
            margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.04,
                SizeConfig.screenWidth * 0.03,
                SizeConfig.screenWidth * 0.04,
                0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.05),
                color: AppColor.white),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth * 0.04,
                fontWeight: FontWeight.w400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 0.05),
                            color: AppColor.yellowFFF59D),
                        child: Image.asset(
                          Assets.bloodPressureicon,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(translation(context).bloodPressure,
                                      style: AppTextTheme.title3.copyWith(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.045,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('HH:mm dd/MM/yyyy').format(
                                          state.viewModel.bloodPressureEntity!
                                              .updatedDate!),
                                      style: AppTextTheme.title3.copyWith(
                                          color: AppColor.gray767676,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.035,
                                          fontWeight: FontWeight.bold))
                                ]),
                            GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      editSys.text =
                                          "${state.viewModel.bloodPressureEntity?.sys}";
                                      editDia.text =
                                          "${state.viewModel.bloodPressureEntity?.dia}";
                                      editPul.text =
                                          "${state.viewModel.bloodPressureEntity?.pulse}";
                                      return AlertDialog(
                                        title: Text(translation(context)
                                            .editIndicatore),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                height: SizeConfig.screenWidth *
                                                    0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColor
                                                      .cardBackgroundColor,
                                                ),
                                                child: TextField(
                                                  controller: editSys,
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "SYS:",
                                                    labelStyle: TextStyle(
                                                        color:
                                                            AppColor.gray767676,
                                                        fontSize: SizeConfig
                                                                .screenWidth *
                                                            0.05),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                height: SizeConfig.screenWidth *
                                                    0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColor
                                                      .cardBackgroundColor,
                                                ),
                                                child: TextField(
                                                  controller: editDia,
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "DIA:",
                                                    labelStyle: TextStyle(
                                                        color:
                                                            AppColor.gray767676,
                                                        fontSize: SizeConfig
                                                                .screenWidth *
                                                            0.05),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidth *
                                                            0.025),
                                                height: SizeConfig.screenWidth *
                                                    0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColor
                                                      .cardBackgroundColor,
                                                ),
                                                child: TextField(
                                                  controller: editPul,
                                                  style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "PUL:",
                                                    labelStyle: TextStyle(
                                                        color:
                                                            AppColor.gray767676,
                                                        fontSize: SizeConfig
                                                                .screenWidth *
                                                            0.05),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  translation(context).back)),
                                          TextButton(
                                            child:
                                                Text(translation(context).save),
                                            onPressed: () {
                                              int? editedDia =
                                                  int.parse(editDia.text);
                                              int? editedSys =
                                                  int.parse(editSys.text);
                                              int? editedPul =
                                                  int.parse(editPul.text);
                                              scanBloc.add(
                                                  EditBloodPressureDataEvent(
                                                      context: context,
                                                      editedDia: editedDia,
                                                      editedPul: editedPul,
                                                      editedSys: editedSys));

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.075,
                                    height: SizeConfig.screenWidth * 0.075,
                                    child: Image.asset(Assets.edit)))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: SizeConfig.screenWidth * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "${state.viewModel.bloodPressureEntity?.sys}/${state.viewModel.bloodPressureEntity?.dia}",
                                style: AppTextTheme.title3.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.13,
                                    fontWeight: FontWeight.w500,
                                    color: state.viewModel.bloodPressureEntity
                                        ?.statusColor)),
                            Text("mmHg",
                                style: AppTextTheme.title3.copyWith(
                                    color: const Color(0xff615A5A),
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "${state.viewModel.bloodPressureEntity?.pulse}",
                                style: AppTextTheme.title3.copyWith(
                                    color: state.viewModel.bloodPressureEntity
                                        ?.statusColor,
                                    fontSize: SizeConfig.screenWidth * 0.08,
                                    fontWeight: FontWeight.w500)),
                            Text("bpm",
                                style: AppTextTheme.title3.copyWith(
                                    color: const Color(0xff615A5A),
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
              child: CommonButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadBloodPressureDataEvent());
            },
          ))
        ],
      ),
    );
  }

  Widget bloodGlucoseCell(OCRScannerState state) {
    return Center(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.24,
            width: SizeConfig.screenWidth * 0.8,
            margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(
                SizeConfig.screenWidth * 0.04,
                SizeConfig.screenWidth * 0.03,
                SizeConfig.screenWidth * 0.04,
                0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.05),
                color: AppColor.white),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenWidth * 0.04,
                fontWeight: FontWeight.w400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 0.05),
                            color: AppColor.bodyTemperatureColor),
                        child: Image.asset(
                          Assets.bloodSugar,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(translation(context).bloodSugar,
                                      style: AppTextTheme.title3.copyWith(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.04,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('HH:mm dd/MM/yyyy').format(
                                          state.viewModel.bloodSugarEntity!
                                              .updatedDate!),
                                      style: AppTextTheme.title3.copyWith(
                                          color: AppColor.gray767676,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.035,
                                          fontWeight: FontWeight.bold))
                                ]),
                            GestureDetector(
                                child: SizedBox(
                                    width: SizeConfig.screenWidth * 0.075,
                                    height: SizeConfig.screenWidth * 0.075,
                                    child: Image.asset(Assets.edit)),
                                onTap: () {
                                  showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        editBloogSugarController.text =
                                            "${state.viewModel.bloodSugarEntity?.bloodSugar}";

                                        return AlertDialog(
                                          title: Text(translation(context)
                                              .editIndicatore),
                                          content: Container(
                                            margin: EdgeInsets.only(
                                                bottom: SizeConfig.screenWidth *
                                                    0.025),
                                            padding: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.025),
                                            height:
                                                SizeConfig.screenWidth * 0.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  AppColor.cardBackgroundColor,
                                            ),
                                            child: TextField(
                                              controller:
                                                  editBloogSugarController,
                                              style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Glucose:",
                                                labelStyle: TextStyle(
                                                    color: AppColor.gray767676,
                                                    fontSize:
                                                        SizeConfig.screenWidth *
                                                            0.05),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    translation(context).back)),
                                            TextButton(
                                              child: Text(
                                                  translation(context).save),
                                              onPressed: () {
                                                double? editedBloodSugar =
                                                    double.parse(
                                                        editBloogSugarController
                                                            .text);

                                                setState(() {});
                                                scanBloc.add(
                                                    EditBloodSugarDataEvent(
                                                  context: context,
                                                  glucose: editedBloodSugar,
                                                ));

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                      width: SizeConfig.screenWidth * 0.7,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "${state.viewModel.bloodSugarEntity?.bloodSugar}",
                                  style: AppTextTheme.title3.copyWith(
                                      color: state.viewModel.bloodSugarEntity
                                          ?.statusColor,
                                      fontSize: SizeConfig.screenWidth * 0.15,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: " mg/dL",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.05,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
              child: CommonButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadBloodGlucoseDataEvent());
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
            elevation: SizeConfig.screenWidth * 0.03,
            borderRadius: BorderRadius.all(
                Radius.circular(SizeConfig.screenWidth * 0.05)),
            child: Container(
              height: SizeConfig.screenWidth * 0.8,
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.05),
              ),
              child: imageFile == null
                  ? GestureDetector(
                      onTap: () async {
                        scanBloc.add(event);
                      },
                      child: Image.asset(
                        Assets.icCameraAdd,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(
                          SizeConfig.screenWidth * 0.05),
                      child: FullScreenWidget(
                          disposeLevel: DisposeLevel.High,
                          child: Image.file(File(imageFile.path),
                              fit: BoxFit.fill)),
                    ),
            ),
          ),
        ),
        imageFile != null
            ? Positioned(
                bottom: -SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.01,
                child: InkWell(
                  onTap: () {
                    scanBloc.add(event);
                  },
                  child: Container(
                      height: SizeConfig.screenWidth * 0.15,
                      width: SizeConfig.screenWidth * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.08)),
                      child: Icon(
                        Icons.autorenew_rounded,
                        size: SizeConfig.screenWidth * 0.1,
                        color: Colors.blue,
                      )),
                ),
              )
            : Container(),
      ],
    );
  }
}
