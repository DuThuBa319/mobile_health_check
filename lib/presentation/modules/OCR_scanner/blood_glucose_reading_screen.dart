import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../classes/language.dart';

import '../../../utils/size_config.dart';
import '../../../assets/assets.dart';

import '../../common_widget/common.dart';
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
  void initState() {
    super.initState();
    scanBloc.add(StartUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
      title: translation(context).bloodGlucoseMeter,
      isShowAppBar: true,
      isShowLeadingButton: true,
      leadingButton: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: SizeConfig.screenHeight * 0.04,
          color: Colors.white,
        ),
        onPressed: () {
          userDataData.localDataManager.preferencesHelper.remove("Indicator");
          Navigator.pop(context);
        },
      ),
      appComponentColor: Colors.white,
      backgroundColor: AppColor.blueD0F7FF,
      appBarColor: AppColor.topGradient,
      child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
          listener: blocListener,
          builder: (context, scanState) {
            if (scanState.status == BlocStatusState.loading) {
              return processingLoading(context);
            }
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Blood Glucose Meter
                    InstructionScanner(
                      imagesTakenToday:
                          // userDataData.getUser()!.imagesTakenToday,
                          userDataData.getUser()!.bloodSugarImagesTakenToday,
                      measuringTask: MeasuringTask.bloodSugar,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.055),
                    imagePickerCell(context,
                        imagesTakenToday:
                            userDataData.getUser()!.bloodSugarImagesTakenToday,
                        scanBloc: scanBloc,
                        state: scanState,
                        imageFile: scanState.viewModel.bloodGlucoseImageFile,
                        event: GetBloodGlucoseDataEvent(context: context)),
                    SizedBox(height: SizeConfig.screenHeight * 0.055),
                    scanState.viewModel.bloodGlucoseImageFile != null
                        ? bloodGlucoseCell(scanState)
                        : const SizedBox()
                  ]),
            );
          }),
    );
  }

  Widget bloodGlucoseCell(OCRScannerState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.screenDiagonal < 1350
                ? SizeConfig.screenHeight * 0.24
                : SizeConfig.screenHeight * 0.35,
            width: SizeConfig.screenWidth * 0.8,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.all(SizeConfig.screenWidth * 0.03),
                            width: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.2
                                : SizeConfig.screenWidth * 0.15,
                            height: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.2
                                : SizeConfig.screenWidth * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.screenDiagonal < 1350
                                      ? SizeConfig.screenWidth * 0.05
                                      : SizeConfig.screenWidth * 0.035),
                                color: AppColor.bodyTemperatureColor),
                            child: Image.asset(
                              Assets.bloodSugar,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.01,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(translation(context).bloodSugar,
                                    style: AppTextTheme.title3.copyWith(
                                        color: Colors.black,
                                        fontSize:
                                            SizeConfig.screenWidth * 0.035,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    DateFormat('HH:mm dd/MM/yyyy').format(state
                                        .viewModel
                                        .bloodSugarEntity!
                                        .updatedDate!),
                                    style: AppTextTheme.title3.copyWith(
                                        color: AppColor.gray767676,
                                        fontSize: SizeConfig.screenWidth * 0.03,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ],
                      ),
                      //! Edit indicator
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
                                  double? bloodSugarValue = state
                                      .viewModel.bloodSugarEntity?.bloodSugar;
                                  editBloogSugarController.text =
                                      bloodSugarValue != null
                                          ? "$bloodSugarValue"
                                          : "--";

                                  return AlertDialog(
                                    title: Text(
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.03,
                                        ),
                                        translation(context).editIndicatore),
                                    content: Container(
                                      width: SizeConfig.screenWidth * 0.5,
                                      height: SizeConfig.screenHeight * 0.1,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeConfig.screenWidth * 0.025),
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.025),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColor.cardBackgroundColor,
                                      ),
                                      child: TextField(
                                        controller: editBloogSugarController,
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.05,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText:
                                              translation(context).bloodSugar,
                                          labelStyle: TextStyle(
                                              color: AppColor.gray767676,
                                              fontSize: SizeConfig.screenWidth *
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
                                            translation(context).back,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.03),
                                          )),
                                      TextButton(
                                        child: Text(
                                          translation(context).save,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig.screenWidth *
                                                  0.03),
                                        ),
                                        onPressed: () {
                                          double? editedBloodSugar =
                                              double.parse(
                                                  editBloogSugarController
                                                      .text);

                                          setState(() {});
                                          scanBloc.add(EditBloodSugarDataEvent(
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
                  Expanded(
                      child: state.viewModel.bloodSugarEntity?.bloodSugar !=
                              null
                          ? SizedBox(
                              width: SizeConfig.screenWidth * 0.7,
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: (userDataData.localDataManager.preferencesHelper
                                                      .getData("Indicator") ==
                                                  null)
                                              ? "${state.viewModel.bloodSugarEntity?.bloodSugar}"
                                              : (userDataData.localDataManager
                                                          .preferencesHelper
                                                          .getData(
                                                              "Indicator") ==
                                                      20)
                                                  ? "LO"
                                                  : "HI",
                                          style: AppTextTheme.title3.copyWith(
                                              color: (userDataData
                                                          .localDataManager
                                                          .preferencesHelper
                                                          .getData(
                                                              "Indicator") ==
                                                      20)
                                                  ? AppColor.blue0089D7
                                                  : (userDataData
                                                              .localDataManager
                                                              .preferencesHelper
                                                              .getData(
                                                                  "Indicator") ==
                                                          600)
                                                      ? AppColor
                                                          .exceptionDialogIconColor
                                                      : state
                                                          .viewModel
                                                          .bloodSugarEntity
                                                          ?.statusColor,
                                              fontSize: SizeConfig.screenWidth * 0.15,
                                              fontWeight: FontWeight.w500)),
                                      (userDataData.localDataManager
                                                      .preferencesHelper
                                                      .getData("Indicator") !=
                                                  20 &&
                                              userDataData.localDataManager
                                                      .preferencesHelper
                                                      .getData("Indicator") !=
                                                  600)
                                          ? TextSpan(
                                              text: " mg/dL",
                                              style:
                                                  AppTextTheme.title3
                                                      .copyWith(
                                                          color: const Color(
                                                              0xff615A5A),
                                                          fontSize: SizeConfig
                                                                  .screenWidth *
                                                              0.05,
                                                          fontWeight:
                                                              FontWeight.w500))
                                          : const TextSpan()
                                    ],
                                  ),
                                ),
                              ))
                          : (userDataData.localDataManager.preferencesHelper
                                      .getData("Indicator") ==
                                  20)
                              ? Center(
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      "LOW",
                                      style: AppTextTheme.title3.copyWith(
                                          color: AppColor.blue0089D7,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.18,
                                          fontWeight: FontWeight.w500)),
                                )
                              : (userDataData.localDataManager.preferencesHelper
                                          .getData("Indicator") ==
                                      600)
                                  ? Center(
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          "HI",
                                          style: AppTextTheme.title3.copyWith(
                                              color: AppColor.blue0089D7,
                                              fontSize:
                                                  SizeConfig.screenWidth * 0.18,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  : Center(
                                      child: Text(
                                          translation(context)
                                              .unableToRecognizeReading,
                                          textAlign: TextAlign.center,
                                          style: AppTextTheme.title3.copyWith(
                                              color: AppColor
                                                  .exceptionDialogIconColor,
                                              fontSize:
                                                  SizeConfig.screenWidth * 0.04,
                                              fontWeight: FontWeight.w500)),
                                    ))
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.035),
          RectangleButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadBloodGlucoseDataEvent());
            },
          )
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
