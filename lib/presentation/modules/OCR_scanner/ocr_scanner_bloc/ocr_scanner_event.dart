part of 'ocr_scanner_bloc.dart';

@immutable
abstract class OCRScannerEvent {}

class StartUpEvent extends OCRScannerEvent {
  StartUpEvent();
}
//---------- Blood Pressure ------------------------

class GetBloodPressureDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetBloodPressureDataEvent({required this.context});
}

class UploadBloodPressureDataEvent extends OCRScannerEvent {
  UploadBloodPressureDataEvent();
}

class UploadBloodGlucoseDataEvent extends OCRScannerEvent {
  UploadBloodGlucoseDataEvent();
}

class GetPatientImageTakenEvent extends OCRScannerEvent {
   final String patientId;
 GetPatientImageTakenEvent({required this.patientId}) : super();

}

class EditBloodPressureDataEvent extends OCRScannerEvent {
  final int? editedSys;

  final int? editedPul;
  final BuildContext context;
  EditBloodPressureDataEvent(
      {required this.context,
      required this.editedPul,
      required this.editedSys});
}

//----- Blood Sugar ----------------

class GetBloodGlucoseDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetBloodGlucoseDataEvent({required this.context});
}

class EditBloodSugarDataEvent extends OCRScannerEvent {
  final double? glucose;
  final BuildContext context;
  EditBloodSugarDataEvent({
    required this.context,
    required this.glucose,
  });
}

//-------Temperature ----------

class GetTemperatureDataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetTemperatureDataEvent({required this.context});
}

class UploadTemperatureDataEvent extends OCRScannerEvent {
  UploadTemperatureDataEvent();
}

class EditBodyTemperatureDataEvent extends OCRScannerEvent {
  final double? temperature;

  final BuildContext context;
  EditBodyTemperatureDataEvent({
    required this.context,
    required this.temperature,
  });
}

//--------Spo2---------------------------

class GetSpo2DataEvent extends OCRScannerEvent {
  final BuildContext context;
  GetSpo2DataEvent({required this.context});
}

class UploadSpo2DataEvent extends OCRScannerEvent {
  UploadSpo2DataEvent();
}

class EditSpo2DataEvent extends OCRScannerEvent {
  final int? spo2;
  final BuildContext context;
  EditSpo2DataEvent({
    required this.context,
    required this.spo2,
  });
}
