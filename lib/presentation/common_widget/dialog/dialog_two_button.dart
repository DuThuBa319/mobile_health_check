import 'package:flutter/material.dart';

import '../../../classes/language.dart';
import '../../theme/theme_color.dart';

Future<dynamic> showNoticeDialogTwoButton({
  required BuildContext context,
  required String message,
  required String? title,
  required String? titleBtn1,
  required String? titleBtn2,
  bool barrierDismissible = false,
  Function()? onClose1,
  Function()? onClose2,
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

      return AlertDialog(
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
              onClose1?.call();
            },
            child: Text(titleBtn1 ?? translation(context).accept,
                style: const TextStyle(color: AppColor.black)),
          ),
          TextButton(
            onPressed: () {
              dismissFunc.call();
              onClose2?.call();
            },
            child: Text(
              titleBtn2 ?? translation(context).exit,
              style: const TextStyle(color: AppColor.black),
            ),
          )
        ],
      );
    },
  );
}
