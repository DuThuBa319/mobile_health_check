// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:gap/gap.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mobile_health_check/classes/language.dart';

import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../common/singletons.dart';
import '../../../../utils/size_config.dart';
import '../../../common_widget/common.dart';
import 'package:mobile_health_check/presentation/modules/pick_equipment/pick_equipment_screen.dart';
import '../../../theme/theme_color.dart';
import '../ocr_scanner_bloc/ocr_scanner_bloc.dart';

Widget imagePickerCell(BuildContext context,
    {File? imageFile,
    required OCRScannerEvent event,
    required OCRScannerState state,
    required OCRScannerBloc scanBloc}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Center(
        child: Material(
          elevation: SizeConfig.screenWidth * 0.03,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.screenWidth * 0.05)),
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
                      await [
                        // Request camera and microphone permissions
                        Permission.camera,
                        Permission.microphone,
                      ].request();
                      if (await Permission.camera.status ==
                              PermissionStatus.granted &&
                          await Permission.microphone.status ==
                              PermissionStatus.granted) {
                        scanBloc.add(event);
                      } else {
                        await showWarningDialog(
                            context: context,
                            message: translation(context).permissionWarning,
                            onClose1: () {},
                            onClose2: () async {
                              await openAppSettings();
                            });
                      }
                    },
                    child: Icon(
                      Symbols.linked_camera_rounded,
                      weight: 100,
                      size: SizeConfig.screenDiagonal * 0.3,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(
                        SizeConfig.screenWidth * 0.05),
                    child: FullScreenWidget(
                        disposeLevel: DisposeLevel.High,
                        child:
                            Image.file(File(imageFile.path), fit: BoxFit.fill)),
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

Widget processingLoading(BuildContext context) {
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

class InstructionScanner extends StatefulWidget {
  final MeasuringTask measuringTask;

  const InstructionScanner({super.key, required this.measuringTask});

  @override
  State<InstructionScanner> createState() => _InstructionScannerState();
}

class _InstructionScannerState extends State<InstructionScanner> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    String assetString = "";
    if (widget.measuringTask == MeasuringTask.bloodPressure) {
      assetString = bloodPressureEquipModel[userDataData
          .localDataManager.preferencesHelper
          .getData('BloodPressureEquipModel')];
    } else if (widget.measuringTask == MeasuringTask.bloodSugar) {
      assetString = bloodSugarEquipModel[userDataData
          .localDataManager.preferencesHelper
          .getData('BloodSugarEquipModel')];
    }
    if (widget.measuringTask == MeasuringTask.temperature) {
      assetString = temperatureEquipModel[userDataData
          .localDataManager.preferencesHelper
          .getData('TempEquipModel')];
    }
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.16,
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.orange.shade400,
                        size: SizeConfig.screenDiagonal * 0.03,
                      ),
                      const Gap(5),
                      Text(translation(context).deviceMatchImage,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.038,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.blue.shade400,
                        size: SizeConfig.screenDiagonal * 0.03,
                      ),
                      const Gap(5),
                      Text(translation(context).press,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.038,
                              fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.autorenew,
                        color: Colors.blue.shade400,
                        size: SizeConfig.screenDiagonal * 0.03,
                      ),
                      Text(translation(context).toChangeTheDevice,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.038,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: const Color.fromARGB(255, 106, 247, 111),
                        size: SizeConfig.screenDiagonal * 0.03,
                      ),
                      const Gap(5),
                      Text(translation(context).press,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.038,
                              fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.linked_camera_outlined,
                        color: Colors.blue.shade400,
                        size: SizeConfig.screenDiagonal * 0.03,
                      ),
                      Text(translation(context).toCaptureTheResult,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth * 0.038,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Stack(children: [
              Container(
                width: SizeConfig.screenWidth * 0.23,
                height: SizeConfig.screenHeight * 0.12,
                margin: const EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: AppColor.appBarColor,
                    borderRadius: BorderRadius.circular(8)),
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.Medium,
                  child: Image.asset(assetString, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                bottom: SizeConfig.screenWidth * 0.001,
                right: SizeConfig.screenWidth * 0.001,
                child: InkWell(
                  child: Container(
                      height: SizeConfig.screenWidth * 0.08,
                      width: SizeConfig.screenWidth * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.08)),
                      child: Icon(
                        Icons.autorenew_rounded,
                        size: SizeConfig.screenWidth * 0.07,
                        color: Colors.blue,
                      )),
                  onTap: () async {
                    if (widget.measuringTask == MeasuringTask.bloodPressure) {
                      await selectModelDialog(
                        context,
                        modelAssets: bloodPressureEquipModel,
                        measuringTask: MeasuringTask.bloodPressure,
                      );
                      setState(() {});
                    } else if (widget.measuringTask ==
                        MeasuringTask.bloodSugar) {
                      await selectModelDialog(
                        context,
                        modelAssets: bloodSugarEquipModel,
                        measuringTask: MeasuringTask.bloodSugar,
                      );
                    } else if (widget.measuringTask ==
                        MeasuringTask.temperature) {
                      await selectModelDialog(
                        context,
                        modelAssets: temperatureEquipModel,
                        measuringTask: MeasuringTask.temperature,
                      );
                    }
                    setState(() {});
                  },
                ),
              )
            ]),
            emptySpace(SizeConfig.screenWidth * 0.015),
          ]),
    );
  }
}
