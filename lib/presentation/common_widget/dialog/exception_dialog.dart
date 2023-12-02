import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../classes/language.dart';
import '../../../utils/size_config.dart';

Future<dynamic> showExceptionDialog({
  required BuildContext context,
  required String message,
  required String? titleBtn,
  bool barrierDismissible = false,
  Function()? onClose,
  bool useRootNavigator = false,
  bool dismissWhenAction = true,
}) {
  dismissFunc() {
    if (dismissWhenAction) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  }

  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);
      showAndroidDialog() => AlertDialog(
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(2))),
            backgroundColor: AppColor.white,
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: SizeConfig.screenHeight * 0.25,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                color: AppColor.white,
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    height: SizeConfig.screenHeight * 0.1,
                    width: SizeConfig.screenWidth,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28)),
                      color: AppColor.exceptionDialogColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: SizeConfig.screenWidth * 0.1,
                            height: SizeConfig.screenWidth * 0.1,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColor.white),
                            child: Icon(
                              size: SizeConfig.screenWidth * 0.09,
                              Icons.error,
                              color: AppColor.exceptionDialogIconColor,
                            )),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("${translation(context).error}!",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenWidth * 0.045),
                            textAlign: TextAlign.center),
                      ],
                    )),
                Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                      height: SizeConfig.screenHeight * 0.15,
                      width: SizeConfig.screenWidth * 0.72,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: SizeConfig.screenWidth * 0.04),
                      ),
                    ),
                    Positioned(
                      top: SizeConfig.screenHeight * 0.085,
                      left: SizeConfig.screenWidth * 0.51,
                      child: GestureDetector(
                        onTap: () {
                          dismissFunc.call();
                          onClose?.call();
                        },
                        child: Container(
                          width: SizeConfig.screenWidth * 0.2,
                          height: SizeConfig.screenHeight * 0.05,
                          decoration: const BoxDecoration(
                              color: AppColor.successDialog,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              titleBtn ?? translation(context).accept,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.04,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          );

      //! PHẦN NÀY DÀNH CHO IOS ==> chưa chỉnh sửa
      if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        return CupertinoAlertDialog(
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                dismissFunc.call();
                onClose?.call();
              },
              child: Text(
                titleBtn ?? translation(context).accept,
                style: const TextStyle(color: AppColor.black),
              ),
            ),
          ],
        );
      }
    },
  );
}
