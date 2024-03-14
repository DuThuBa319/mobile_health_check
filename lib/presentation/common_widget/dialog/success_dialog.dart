import 'package:flutter/material.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../classes/language.dart';
import '../../../utils/size_config.dart';

//! RESET PASSWORD - DONE
//! UPDATE PROFILE  - DONE
//! CHANGE PASSWORD - DONE
//! ADD PATIENT - DONE
//! ADD RELATIVE - DONE
//! ADD DOCTOR - DONE

Future<dynamic> showSuccessDialog({
  required BuildContext context,
  required String message,
  required String? title,
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
          backgroundColor: AppColor.white,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: SizeConfig.screenDiagonal < 1350
                ? SizeConfig.screenHeight * 0.25
                : SizeConfig.screenHeight * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.screenWidth * 0.02)),
              color: AppColor.white,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.screenWidth * 0.02),
                        topRight:
                            Radius.circular(SizeConfig.screenWidth * 0.022)),
                    color: AppColor.successDialog,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: SizeConfig.screenDiagonal * 0.035,
                          height: SizeConfig.screenDiagonal * 0.035,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.white),
                          child: Icon(
                            size: SizeConfig.screenDiagonal * 0.035,
                            Icons.check_circle,
                            color: const Color.fromARGB(255, 118, 184, 255),
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      Text("$title!",
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.screenWidth * 0.04),
                          textAlign: TextAlign.center),
                    ],
                  )),
              Stack(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    height: SizeConfig.screenDiagonal < 1350
                        ? SizeConfig.screenHeight * 0.15
                        : SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.72,
                    child: Text(
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: contentDialogSize ??
                              SizeConfig.screenWidth * 0.045),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenDiagonal < 1350
                        ? SizeConfig.screenHeight * 0.085
                        : SizeConfig.screenHeight * 0.12,
                    left: SizeConfig.screenWidth * 0.51,
                    child: GestureDetector(
                      onTap: () {
                        dismissFunc.call();
                        onClose?.call();
                      },
                      child: Container(
                        width: SizeConfig.screenWidth * 0.2,
                        height: SizeConfig.screenDiagonal < 1350
                            ? SizeConfig.screenHeight * 0.04
                            : SizeConfig.screenHeight * 0.05,
                        decoration: const BoxDecoration(
                            color: AppColor.lineDecor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
            ]),
          ),
        );
      });
}
