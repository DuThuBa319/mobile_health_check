import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../../classes/language.dart';
import '../../../../function.dart';
import '../../../common_widget/assets.dart';
import '../../../route/route_list.dart';
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

Future<dynamic> successAlert(
  BuildContext context, {
  required String alertText,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Center(
      child: AlertDialog(
        title: Text(translation(context).notification),
        content: Text(
          alertText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          TextButton(
            child: Text(translation(context).exit),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, RouteList.selectEquip,
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    ),
  );
}
