import 'package:flutter/material.dart';

Future<dynamic> showLoadingDialog({
  required BuildContext context,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // Wrap the dialog in a WillPopScope widget to intercept back button
      return WillPopScope(
        onWillPop: () async {
          // Prevent back navigation while the loading dialog is displayed
          return false;
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
