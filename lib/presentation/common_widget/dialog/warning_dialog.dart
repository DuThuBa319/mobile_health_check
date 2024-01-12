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
  required String? title,
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

  return showAdaptiveDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return AlertDialog.adaptive(
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
                    color: AppColor.warningDialogColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: SizeConfig.screenWidth * 0.11,
                          height: SizeConfig.screenWidth * 0.11,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.white),
                          child: Icon(
                            size: SizeConfig.screenWidth * 0.11,
                            Icons.help,
                            color: AppColor.warningDialogIconColor,
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      Text("$title?",
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
                          fontSize: contentDialogSize ??
                              SizeConfig.screenWidth * 0.04),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.085,
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
                              height: SizeConfig.screenHeight * 0.055,
                              decoration: const BoxDecoration(
                                  color: AppColor.graybebebe,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  translation(context).no,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.05,
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
                              height: SizeConfig.screenHeight * 0.055,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 118, 184, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  translation(context).yes,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.05,
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
