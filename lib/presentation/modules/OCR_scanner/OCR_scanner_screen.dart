import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

class OCRScannerScreen extends StatefulWidget {
  const OCRScannerScreen({super.key});

  @override
  State<OCRScannerScreen> createState() => _OCRScannerScreenState();
}

class _OCRScannerScreenState extends State<OCRScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: 'OCR Scanner',
      isShowAppBar: true,
      isShowLeadingButton: true,
      backgroundColor: Colors.white,
      appBarColor: Colors.blue,
      child: Container(),
    );
  }
}
