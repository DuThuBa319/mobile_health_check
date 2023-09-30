import 'package:flutter/material.dart';

Future<dynamic> showLoadingDialog({
  required BuildContext context,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
