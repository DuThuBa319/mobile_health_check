import 'package:intl/intl.dart';
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
                      //! Spo2spo2
                      // Text(
                      //   translation(context).spo2,
                      //   style: AppTextTheme.title2,
                      // ),
                      SizedBox(height: SizeConfig.screenWidth * 0.15),
                      imagePickerCell(context,
                          scanBloc: scanBloc,
                          state: scanState,
                          imageFile: scanState.viewModel.spo2ImageFile,
                          event: GetSpo2DataEvent(context: context)),
                      SizedBox(
                        height: SizeConfig.screenWidth * 0.08,
                      ),
                      scanState.viewModel.spo2ImageFile != null
                          ? spo2Cell(scanState)
                          : Center(
                              child: Column(
                              children: [
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
              ),
            );
          }),
    );
  }

  Widget spo2Cell(OCRScannerState state) {
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
                          color: AppColor.oximeterCell,
                        ),
                        child: Image.asset(
                          Assets.oximeter,
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
                                  Text(translation(context).spo2,
                                      style: AppTextTheme.title3.copyWith(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.screenWidth * 0.035,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('HH:mm dd/MM/yyyy').format(
                                          state.viewModel.spo2Entity!
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
                                        editSpo2Controller.text =
                                            "${state.viewModel.spo2Entity?.spo2}";
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
                                              controller: editSpo2Controller,
                                              style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.05,
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText:
                                                    translation(context).spo2,
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
                                                int? editedSpo2 = int.parse(
                                                    editSpo2Controller.text);

                                                setState(() {});
                                                scanBloc.add(EditSpo2DataEvent(
                                                    context: context,
                                                    spo2: editedSpo2));

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
                              text: "${state.viewModel.spo2Entity?.spo2}",
                              style: AppTextTheme.title3.copyWith(
                                  color:
                                      state.viewModel.spo2Entity?.statusColor,
                                  fontSize: SizeConfig.screenWidth * 0.15,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "%",
                              style: AppTextTheme.title3.copyWith(
                                  color: const Color(0xff615A5A),
                                  fontSize: SizeConfig.screenWidth * 0.15,
                                  fontWeight: FontWeight.w500))
                        ])),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
              child: RectangleButton(
            height: SizeConfig.screenWidth * 0.18,
            width: SizeConfig.screenWidth * 0.8,
            title: translation(context).upload,
            onTap: () {
              scanBloc.add(UploadSpo2DataEvent());
            },
          ))
        ],
      ),
    );
  }
}
