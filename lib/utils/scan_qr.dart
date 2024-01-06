import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<void> scanQR() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#e60000',
      'Cancel',
      true,
      ScanMode.QR, //! hoac barcode
    );
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }

  if (barcodeScanRes == '-1') {
    // showToast('Quét không thành công');
  } else {
    //? do sonething
    // textController = barcodeScanRes;
    // showToast(textController);
  }
}
