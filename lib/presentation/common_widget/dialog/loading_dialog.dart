import 'package:flutter/material.dart';

Future<dynamic> showLoadingDialog({
  required BuildContext context,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // Wrap the dialog in a WillPopScope widget to intercept back button
      return const PopScope(
        canPop: false,
        onPopInvoked: null,
        // Prevent back navigation while the loading dialog is displayed

        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
