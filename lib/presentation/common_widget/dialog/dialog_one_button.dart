import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../classes/language.dart';

Future<dynamic> showNoticeDialog({
  required BuildContext context,
  required String message,
  required String? title,
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
            title: Text(
              title ?? translation(context).notification,
              style: theme.textTheme.headlineSmall,
            ),
            content: Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  dismissFunc.call();
                  onClose?.call();
                },
                child: Text(
                  titleBtn ?? translation(context).accept,
                  style: const TextStyle(color: AppColor.black),
                ),
              )
            ],
          );

      if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        return CupertinoAlertDialog(
          title: Text(title ?? translation(context).notification),
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

//! showErrorDialog (one button)
//! showSuccessDialog (onebutton)
//! showAlertDialog (two buttons)