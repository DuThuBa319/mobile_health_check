part of 'get_patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class GetPatientListEvent extends PatientEvent {
  GetPatientListEvent();
}

class FilterPatientEvent extends PatientEvent {
  FilterPatientEvent({required this.searchText});
  final String searchText;
}

class RegistPatientEvent extends PatientEvent {
  RegistPatientEvent({required this.patient});
  final PatientModel patient;
}

class GetPatientInforEvent extends PatientEvent {
  final String id;
  GetPatientInforEvent({required this.id}) : super();
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



