import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/singletons.dart';
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
part 'spo2_reading_screen.action.dart';

class Spo2ReadingScreen extends StatefulWidget {
  const Spo2ReadingScreen({super.key});

  @override
  State<Spo2ReadingScreen> createState() => _Spo2ReadingScreenState();
}

class _Spo2ReadingScreenState extends State<Spo2ReadingScreen> {
  String? message = "";
  OCRScannerBloc get scanBloc => BlocProvider.of(context);
  TextEditingController editSpo2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    scanBloc.add(StartUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: translation(context).spo2,
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
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InstructionScanner(
                        imagesTakenToday:
                            userDataData.getUser()!.spO2ImagesTakenToday,
                        measuringTask: MeasuringTask.oximeter,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.045),
                      imagePickerCell(context,
                          measuringTask: MeasuringTask.oximeter,
                          imagesTakenToday:
                              userDataData.getUser()!.spO2ImagesTakenToday,
                          scanBloc: scanBloc,
                          state: scanState,
                          imageFile: scanState.viewModel.spo2ImageFile,
                          event: GetSpo2DataEvent(context: context)),
                      SizedBox(height: SizeConfig.screenHeight * 0.045),
                      scanState.viewModel.spo2ImageFile != null
                          ? spo2Cell(scanState)
                          : const SizedBox()
                    ]),
              ),
            );
          }),
    );
  }

  Widget spo2Cell(OCRScannerState state) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenDiagonal < 1350
              ? SizeConfig.screenHeight * 0.24
              : SizeConfig.screenHeight * 0.35,
          width: SizeConfig.screenWidth * 0.8,
          padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.04,
              SizeConfig.screenWidth * 0.03, SizeConfig.screenWidth * 0.04, 0),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.screenWidth * 0.05),
              color: AppColor.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
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
                          color: AppColor.bloodPressureColor,
                        ),
                        child: Image.asset(
                          Assets.oxi,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.01,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translation(context).spo2,
                                style: AppTextTheme.title3.copyWith(
                                    color: Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat('HH:mm dd/MM/yyyy').format(
                                    state.viewModel.spo2Entity!.updatedDate!),
                                style: AppTextTheme.title3.copyWith(
                                    color: AppColor.gray767676,
                                    fontSize: SizeConfig.screenWidth * 0.03,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ],
                  ),
                  GestureDetector(
                      child: SizedBox(
                          width: SizeConfig.screenWidth * 0.075,
                          height: SizeConfig.screenWidth * 0.075,
                          child: Image.asset(Assets.edit)),
                      onTap: () {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              int? spO2Value = state.viewModel.spo2Entity?.spo2;
                              editSpo2Controller.text =
                                  spO2Value != null ? "$spO2Value" : "--";
                              return AlertDialog(
                                title:
                                    Text(translation(context).editIndicatore),
                                content: Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.screenWidth * 0.025),
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.025),
                                  height: SizeConfig.screenWidth * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.cardBackgroundColor,
                                  ),
                                  child: TextField(
                                    controller: editSpo2Controller,
                                    style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.05,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: translation(context).spo2,
                                      labelStyle: TextStyle(
                                          color: AppColor.gray767676,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.05),
                                    ),
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
                                      int? editedSpo2 =
                                          int.parse(editSpo2Controller.text);

                                      setState(() {});
                                      scanBloc.add(EditSpo2DataEvent(
                                          context: context, spo2: editedSpo2));

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
                child: state.viewModel.spo2Entity?.spo2 != null
                    ? Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "${state.viewModel.spo2Entity?.spo2}",
                                  style: AppTextTheme.title3.copyWith(
                                      color: state
                                          .viewModel.spo2Entity?.statusColor,
                                      fontSize: SizeConfig.screenWidth * 0.175,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "%",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.155,
                                      fontWeight: FontWeight.w500))
                            ])))
                    : Center(
                        child: Text(
                            translation(context).unableToRecognizeReading,
                            textAlign: TextAlign.center,
                            style: AppTextTheme.title3.copyWith(
                                color: AppColor.exceptionDialogIconColor,
                                fontSize: SizeConfig.screenWidth * 0.04,
                                fontWeight: FontWeight.w500)),
                      ),
              )
            ],
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        Center(
            child: RectangleButton(
          height: SizeConfig.screenWidth * 0.18,
          width: SizeConfig.screenWidth * 0.8,
          title: translation(context).upload,
          onTap: () {
            scanBloc.add(UploadSpo2DataEvent());
          },
        )),
        SizedBox(height: SizeConfig.screenHeight * 0.15),
      ],
    );
  }
}
