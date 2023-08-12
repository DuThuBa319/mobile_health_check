part of 'ocr_scanner_bloc.dart';

@immutable
abstract class OCRScannerEvent {}

class GetInitialBloodPressureDataEvent extends OCRScannerEvent {
  GetInitialBloodPressureDataEvent();
}

class GetBloodPressureDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetBloodPressureDataEvent({required this.context});
}

class GetBloodGlucoseDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetBloodGlucoseDataEvent({required this.context});
}

class GetTemperatureDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetTemperatureDataEvent({required this.context});
}

class UploadBloodPressureDataEvent extends OCRScannerEvent {
  UploadBloodPressureDataEvent();
}