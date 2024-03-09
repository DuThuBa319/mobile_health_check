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
  double? contentDialogSize,
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
        return AlertDialog(
          // shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(2))),
          backgroundColor: AppColor.white,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenDiagonal < 1350
                ? SizeConfig.screenHeight * 0.25
                : SizeConfig.screenHeight * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenWidth * 0.04
                    : SizeConfig.screenWidth * 0.025,
              )),
              color: AppColor.white,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenHeight * 0.1
                      : SizeConfig.screenHeight * 0.17,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.04
                              : SizeConfig.screenWidth * 0.02,
                        ),
                        topRight: Radius.circular(
                          SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.04
                              : SizeConfig.screenWidth * 0.02,
                        )),
                    color: AppColor.exceptionDialogColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: SizeConfig.screenDiagonal * 0.04,
                          height: SizeConfig.screenDiagonal * 0.04,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.white),
                          child: Icon(
                            size: SizeConfig.screenDiagonal * 0.035,
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
                              fontSize: SizeConfig.screenWidth * 0.05),
                          textAlign: TextAlign.center),
                    ],
                  )),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                      height: SizeConfig.screenHeight * 0.15,
                      width: SizeConfig.screenWidth * 0.9,
                      child: Text(
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: contentDialogSize ??
                              (SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.055
                                  : SizeConfig.screenWidth * 0.045),
                        ),
                      ),
                    ),
                    Positioned(
                      top: SizeConfig.screenDiagonal < 1350
                          ? SizeConfig.screenHeight * 0.09
                          : SizeConfig.screenHeight * 0.1,
                      left: SizeConfig.screenDiagonal < 1350
                          ? SizeConfig.screenWidth * 0.55
                          : SizeConfig.screenWidth * 0.7,
                      child: GestureDetector(
                        onTap: () {
                          dismissFunc.call();
                          onClose?.call();
                        },
                        child: Container(
                          width: SizeConfig.screenWidth * 0.2,
                          height: SizeConfig.screenHeight * 0.05,
                          decoration: BoxDecoration(
                              color: AppColor.successDialog,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  SizeConfig.screenDiagonal < 1350
                                      ? SizeConfig.screenHeight * 0.02
                                      : SizeConfig.screenHeight * 0.015))),
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              titleBtn ?? translation(context).accept,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.045,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      });
}
