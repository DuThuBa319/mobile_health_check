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
part 'temperature_reading_screen.action.dart';

class TemperatureReadingScreen extends StatefulWidget {
  const TemperatureReadingScreen({super.key});

  @override
  State<TemperatureReadingScreen> createState() =>
      _TemperatureReadingScreenState();
}

class _TemperatureReadingScreenState extends State<TemperatureReadingScreen> {
  String? message = "";
  OCRScannerBloc get scanBloc => BlocProvider.of(context);
  TextEditingController editBodyTemperatureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scanBloc.add(StartUpEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: translation(context).thermometer,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //! Thermometer
                    InstructionScanner(
                      imagesTakenToday: userDataData
                          .getUser()!
                          .bodyTemperatureImagesTakenToday,
                      measuringTask: MeasuringTask.temperature,
                    ),
                    emptySpace(SizeConfig.screenHeight * 0.1),
                    imagePickerCell(context,
                        imagesTakenToday: userDataData
                            .getUser()!
                            .bodyTemperatureImagesTakenToday,
                        scanBloc: scanBloc,
                        state: scanState,
                        imageFile: scanState.viewModel.temperatureImageFile,
                        event: GetTemperatureDataEvent(context: context)),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    scanState.viewModel.temperatureImageFile != null
                        ? temperatureCell(scanState)
                        : const SizedBox()
                  ]),
            );
          }),
    );
  }

  Widget temperatureCell(OCRScannerState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.24,
          width: SizeConfig.screenWidth * 0.8,
          padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.04,
              SizeConfig.screenWidth * 0.03, SizeConfig.screenWidth * 0.04, 0),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.screenWidth * 0.05),
              color: AppColor.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.01),
                        width: SizeConfig.screenWidth * 0.17,
                        height: SizeConfig.screenWidth * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.04),
                          color: AppColor.bodyTemperatureColor,
                        ),
                        child: Image.asset(
                          Assets.temperature,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(translation(context).bodyTemperature,
                                style: AppTextTheme.title3.copyWith(
                                    color: Colors.black,
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat('HH:mm dd/MM/yyyy').format(state
                                    .viewModel.temperatureEntity!.updatedDate!),
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
                              double? tempValue = state
                                  .viewModel.temperatureEntity?.temperature;
                              editBodyTemperatureController.text =
                                  tempValue != null ? "$tempValue" : "--";
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
                                    controller: editBodyTemperatureController,
                                    style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.05,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText:
                                          translation(context).bodyTemperature,
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
                                      double? editedTemperature = double.parse(
                                          editBodyTemperatureController.text);

                                      setState(() {});
                                      scanBloc.add(EditBodyTemperatureDataEvent(
                                          context: context,
                                          temperature: editedTemperature));

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
                child: state.viewModel.temperatureEntity?.temperature != null
                    ? Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${state.viewModel.temperatureEntity?.temperature}",
                                  style: AppTextTheme.title3.copyWith(
                                      color: state.viewModel.temperatureEntity
                                          ?.statusColor,
                                      fontSize: SizeConfig.screenWidth * 0.16,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "°",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.16,
                                      fontWeight: FontWeight.w500)),
                              TextSpan(
                                  text: "C",
                                  style: AppTextTheme.title3.copyWith(
                                      color: const Color(0xff615A5A),
                                      fontSize: SizeConfig.screenWidth * 0.11,
                                      fontWeight: FontWeight.w500))
                            ])))
                    : Center(
                        child: Text(
                            translation(context).unableToRecognizeReading,
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
        Center(
            child: RectangleButton(
          height: SizeConfig.screenWidth * 0.18,
          width: SizeConfig.screenWidth * 0.8,
          title: translation(context).upload,
          onTap: () {
            scanBloc.add(UploadTemperatureDataEvent());
          },
        ))
      ],
    );
  }
}
