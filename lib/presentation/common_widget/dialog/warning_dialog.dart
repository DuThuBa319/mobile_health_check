import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../../utils/size_config.dart';
import '../../theme/theme_color.dart';

//! Delete Patient  - DONE
//! Delete Relative - DONE
//! Delete Doctor   - DONE
//! Log Out - DONE
//! Exit App - DONE

Future<dynamic> showWarningDialog({
  required BuildContext context,
  required String message,
  String? title,
  bool barrierDismissible = false,
  Function()? onClose1,
  Function()? onClose2,
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
                      : SizeConfig.screenHeight * 0.15,
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
                    color: AppColor.warningDialogColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenHeight * 0.042
                              : SizeConfig.screenHeight * 0.05,
                          height: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenHeight * 0.042
                              : SizeConfig.screenHeight * 0.05,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.white),
                          child: Icon(
                            size: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenHeight * 0.04
                                : SizeConfig.screenHeight * 0.045,
                            Icons.help,
                            color: AppColor.warningDialogIconColor,
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      if (title != null)
                        Text("$title?",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenWidth * 0.05),
                            textAlign: TextAlign.center),
                    ],
                  )),
              Stack(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
                    height: SizeConfig.screenDiagonal < 1350
                        ? SizeConfig.screenHeight * 0.145
                        : SizeConfig.screenHeight * 0.185,
                    width: SizeConfig.screenWidth * 0.72,
                    child: Text(
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: contentDialogSize ??
                              (SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenWidth * 0.045
                                  : SizeConfig.screenWidth * 0.038)),
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.screenDiagonal < 1350
                        ? SizeConfig.screenHeight * 0.015
                        : SizeConfig.screenHeight * 0.001,
                    left: SizeConfig.screenWidth * 0.04,
                    right: SizeConfig.screenWidth * 0.04,
                    child: SizedBox(
                      width: SizeConfig.screenWidth * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (useRootNavigator == false) {
                                dismissFunc.call();
                              }

                              onClose1?.call();
                            },
                            child: Container(
                              width: SizeConfig.screenWidth * 0.25,
                              height: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenHeight * 0.045
                                  : SizeConfig.screenHeight * 0.055,
                              decoration: const BoxDecoration(
                                  color: AppColor.graybebebe,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  translation(context).no,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.04,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (useRootNavigator == false) {
                                dismissFunc.call();
                              }
                              onClose2?.call();
                            },
                            child: Container(
                              width: SizeConfig.screenWidth * 0.25,
                              height: SizeConfig.screenDiagonal < 1350
                                  ? SizeConfig.screenHeight * 0.045
                                  : SizeConfig.screenHeight * 0.055,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 118, 184, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  translation(context).yes,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.04,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
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
