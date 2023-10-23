import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form_for_patient.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../classes/language.dart';
import '../../../function.dart';
import '../../common_widget/assets.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';

import '../../theme/app_text_theme.dart';
import 'ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'widget/OCR_scanner_widget.dart';
part 'blood_glucose_reading_screen.action.dart';

class BloodGlucoseReadingScreen extends StatefulWidget {
  const BloodGlucoseReadingScreen({super.key});

  @override
  State<BloodGlucoseReadingScreen> createState() =>
      _BloodGlucoseReadingScreenState();
}

class _BloodGlucoseReadingScreenState extends State<BloodGlucoseReadingScreen> {
  String? message = "";

  OCRScannerBloc get scanBloc => BlocProvider.of(context);

  TextEditingController editBloogSugarController = TextEditingController();
  TextEditingController editBodyTemperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PatientCustomScreenForm(
      
      title: translation(context).bloodGlucoseMeter,
      isShowAppBar: true,
      isShowLeadingButton: true,
      appComponentColor: Colors.white,
      backgroundColor: AppColor.blueD0F7FF,
      appBarColor: AppColor.topGradient,
      child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
          listener: blocListener,
          builder: (context, scanState) {
            if (scanState.status == BlocStatusState.loading) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Loading(
                      brightness: Brightness.light,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      type: MaterialType.transparency,
                      child: Text(
                        translation(context).processing,
                        style: AppTextTheme.body3.copyWith(
                          color: Colors.black,
                          decoration: null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
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
                      imagePickerCell(context,
                          scanBloc: scanBloc,
                          state: scanState,
                          imageFile: scanState.viewModel.bloodGlucoseImageFile,
                          event: GetBloodGlucoseDataEvent(context: context)),
                      SizedBox(
                        height: SizeConfig.screenWidth * 0.08,
                      ),
                      scanState.viewModel.bloodGlucoseImageFile != null
                          ? bloodGlucoseCell(scanState)
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
                                              SizeConfig.screenWidth * 0.035,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('HH:mm dd/MM/yyyy').format(
                                          state.viewModel.bloodSugarEntity!
                                              .updatedDate!),
                                      style: AppTextTheme.title3.copyWith(
                                          color: AppColor.gray767676,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.03,
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
                                                labelText: translation(context).bloodSugar,
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
