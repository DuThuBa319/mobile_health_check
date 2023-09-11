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

class UploadBloodGlucoseDataEvent extends OCRScannerEvent {
  UploadBloodGlucoseDataEvent();
}

class UploadTemperatureDataEvent extends OCRScannerEvent {
  UploadTemperatureDataEvent();
}

class EditBloodPressureDataEvent extends OCRScannerEvent {
  final int? editedSys;
  final int? editedDia;
  final int? editedPul;
  final BuildContext context;
  EditBloodPressureDataEvent(
      {required this.context,
      required this.editedDia,
      required this.editedPul,
      required this.editedSys});
}

class EditBloodSugarDataEvent extends OCRScannerEvent {
  final double? glucose;
  final BuildContext context;
  EditBloodSugarDataEvent({
    required this.context,
    required this.glucose,
  });
}

class EditBodyTemperatureDataEvent extends OCRScannerEvent {
  final double? temperature;

  final BuildContext context;
  EditBodyTemperatureDataEvent({
    required this.context,
    required this.temperature,
  });
}
