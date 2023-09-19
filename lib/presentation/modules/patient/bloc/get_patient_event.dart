part of 'get_patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class GetPatientListEvent extends PatientEvent {
  // GetPatientListEvent();
  final String id;
  GetPatientListEvent({required this.id}) : super();
}

class FilterPatientEvent extends PatientEvent {
  FilterPatientEvent({required this.searchText, required this.id});
  final String searchText;
  final String id;
}

class DeleteRelativeEvent extends PatientEvent {
  DeleteRelativeEvent({required this.patientId, required this.relativeId});
  final String? relativeId;
  final String? patientId;
}

class DeletePatientEvent extends PatientEvent {
  DeletePatientEvent({required this.patientId, required this.doctorId});
  final String? doctorId;
  final String? patientId;
}
class RegistPatientEvent extends PatientEvent {
  RegistPatientEvent({required this.patientInforModel, this.doctorId});
  final PatientInforModel? patientInforModel;
  final String? doctorId;
}

class RegistRelativeEvent extends PatientEvent {
  RegistRelativeEvent({required this.relativeInforModel, this.patientId,});
  final RelativeInforModel? relativeInforModel;
  final String? patientId;
}

class GetPatientInforEvent extends PatientEvent {
  final String id;
  GetPatientInforEvent({required this.id}) : super();
}

class UpdatePatientInforEvent extends PatientEvent {
  final String? id;
  final PatientInforModel model;
  UpdatePatientInforEvent({required this.model, required this.id}) : super();
}

// class GetBloodPressureHistoryDataEvent extends PatientEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetBloodPressureHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetBloodPressureHistoryInitDataEvent extends PatientEvent {
//   GetBloodPressureHistoryInitDataEvent();
// }

// class GetBloodSugarHistoryDataEvent extends PatientEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetBloodSugarHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetBloodSugarHistoryInitDataEvent extends PatientEvent {
//   GetBloodSugarHistoryInitDataEvent();
// }

// class GetTemperatureHistoryDataEvent extends PatientEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetTemperatureHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetTemperatureHistoryInitDataEvent extends PatientEvent {
//   GetTemperatureHistoryInitDataEvent();
// }

// class FilterPatientEvent extends PatientEvent {
//   FilterPatientEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



