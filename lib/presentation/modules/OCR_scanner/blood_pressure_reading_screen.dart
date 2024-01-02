import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../../../classes/language.dart';
import '../../../utils/size_config.dart';
import '../../../assets/assets.dart';

import '../../common_widget/common.dart';
import '../../theme/app_text_theme.dart';
import 'ocr_scanner_bloc/ocr_scanner_bloc.dart';
import 'widget/OCR_scanner_widget.dart';
part 'blood_pressure_reading_screen.action.dart';

class BloodPressureReadingScreen extends StatefulWidget {
  const BloodPressureReadingScreen({
    super.key,
  });

  @override
  State<BloodPressureReadingScreen> createState() =>
      _BloodPressureReadingScreenState();
}

class _BloodPressureReadingScreenState
    extends State<BloodPressureReadingScreen> {
  String? message = "";

  OCRScannerBloc get scanBloc => BlocProvider.of(context);
  TextEditingController editSys = TextEditingController();

  TextEditingController editPul = TextEditingController();
  @override
  void initState() {
    super.initState();
    scanBloc.add(StartUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: translation(context).bloodPressureMeter,
      isShowAppBar: true,
      isShowLeadingButton: true,
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
                    SizedBox(height: SizeConfig.screenWidth * 0.05),
                    imagePickerCell(context,
                        scanBloc: scanBloc,
                        state: scanState,
                        imageFile: scanState.viewModel.bloodPressureImageFile,
                        event: GetBloodPressureDataEvent(context: context)),
                    SizedBox(
                      height: SizeConfig.screenWidth * 0.08,
                    ),
                    scanState.viewModel.bloodPressureImageFile != null
                        ? bloodPressureCell(scanState)
                        : Center(
                            child: Column(
                            children: [
                              // SizedBox(
                              //     height:
                              //         SizeConfig.screenHeight * 0.33),
                              RectangleButton(
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
            );
          }),
    );
  }

  Widget bloodPressureCell(OCRScannerState state) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.24,
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(translation(context).bloodPressure,
                                  style: AppTextTheme.title3.copyWith(
                                      color: Colors.black,
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  DateFormat('HH:mm dd/MM/yyyy').format(state
                                      .viewModel
                                      .bloodPressureEntity!
                                      .updatedDate!),
                                  style: AppTextTheme.title3.copyWith(
                                      color: AppColor.gray767676,
                                      fontSize: SizeConfig.screenWidth * 0.03,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              editSys.text =
                                  "${state.viewModel.bloodPressureEntity?.sys}";

                              editPul.text =
                                  "${state.viewModel.bloodPressureEntity?.pulse}";
                              return AlertDialog(
                                title:
                                    Text(translation(context).editIndicatore),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                SizeConfig.screenWidth * 0.025),
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.screenWidth * 0.025),
                                        height: SizeConfig.screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.cardBackgroundColor,
                                        ),
                                        child: TextField(
                                          controller: editSys,
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "SYS:",
                                            labelStyle: TextStyle(
                                                color: AppColor.gray767676,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom:
                                                SizeConfig.screenWidth * 0.025),
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.screenWidth * 0.025),
                                        height: SizeConfig.screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.cardBackgroundColor,
                                        ),
                                        child: TextField(
                                          controller: editPul,
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.screenWidth * 0.05,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "PUL:",
                                            labelStyle: TextStyle(
                                                color: AppColor.gray767676,
                                                fontSize:
                                                    SizeConfig.screenWidth *
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
                                      child: Text(translation(context).back)),
                                  TextButton(
                                    child: Text(translation(context).save),
                                    onPressed: () {
                                      int? editedSys = int.parse(editSys.text);
                                      int? editedPul = int.parse(editPul.text);
                                      scanBloc.add(EditBloodPressureDataEvent(
                                          context: context,
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
                Expanded(
                  child:(state.viewModel.bloodPressureEntity?.pulse != null && state.viewModel.bloodPressureEntity?.sys != null ) ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${state.viewModel.bloodPressureEntity?.sys}",
                              style: AppTextTheme.title3.copyWith(
                                  fontSize: SizeConfig.screenWidth * 0.12,
                                  fontWeight: FontWeight.w500,
                                  color: state.viewModel.bloodPressureEntity
                                      ?.statusColor)),
                          Text("mmHg",
                              style: AppTextTheme.title3.copyWith(
                                  color: const Color(0xff615A5A),
                                  fontSize: SizeConfig.screenWidth * 0.05,
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
                          Text("${state.viewModel.bloodPressureEntity?.pulse}",
                              style: AppTextTheme.title3.copyWith(
                                  color: state.viewModel.bloodPressureEntity
                                      ?.statusColor,
                                  fontSize: SizeConfig.screenWidth * 0.08,
                                  fontWeight: FontWeight.w500)),
                          Text("bpm",
                              style: AppTextTheme.title3.copyWith(
                                  color: const Color(0xff615A5A),
                                  fontSize: SizeConfig.screenWidth * 0.05,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ],
                  ):Center(
                    child: Text(translation(context).unableToRecognizeReading,
                            textAlign: TextAlign.center,
                            style: AppTextTheme.title3.copyWith(
                                color: AppColor.exceptionDialogIconColor,
                                fontSize: SizeConfig.screenWidth * 0.055,
                                fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          RectangleButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadBloodPressureDataEvent());
            },
          )
        ],
      ),
    );
  }
}
