part of 'get_patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class GetPatientListEvent extends PatientEvent {
  // GetPatientListEvent();
  final String id;
  GetPatientListEvent({required this.id}) : super();
}
class GetPatientListOfRelativeEvent extends PatientEvent {
  // GetPatientListEvent();
  final String relativeId;
  GetPatientListOfRelativeEvent({required this.relativeId}) : super();
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
class UpdateRelativeInforEvent extends PatientEvent {
  final String? id;
  final RelativeInforModel model;
  UpdateRelativeInforEvent({required this.model, required this.id}) : super();
}




