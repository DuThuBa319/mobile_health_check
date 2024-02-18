// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/presentation/common_widget/loading_widget.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';

import '../../../../utils/size_config.dart';
import '../../../../assets/assets.dart';
import '../../../common_widget/dialog/warning_dialog.dart';
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
                    child: Image.asset(
                      Assets.icCameraAdd,
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
