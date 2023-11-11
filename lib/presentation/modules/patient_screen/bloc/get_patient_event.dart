part of 'get_patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class GetDoctorListEvent extends PatientEvent {
  GetDoctorListEvent() : super();
}

class GetPatientListEvent extends PatientEvent {
  // GetPatientListEvent();
  final String userId;
  GetPatientListEvent({required this.userId}) : super();
}

class FilterPatientEvent extends PatientEvent {
  FilterPatientEvent({required this.searchText, required this.id});
  final String searchText;
  final String id;
}

class RemoveRelationshipRaPEvent extends PatientEvent {
  RemoveRelationshipRaPEvent(
      {required this.patientId, required this.relativeId});
  final String? relativeId;
  final String? patientId;
}

class DeletePatientEvent extends PatientEvent {
  DeletePatientEvent({required this.patientId, required this.doctorId});
  final String? doctorId;
  final String? patientId;
}

class RegistPatientEvent extends PatientEvent {
  RegistPatientEvent({required this.accountEntity, this.doctorId});
  final AccountEntity? accountEntity;
  final String? doctorId;
}

class RegistRelativeEvent extends PatientEvent {
  RegistRelativeEvent({
    required this.accountEntity,
    this.patientId,
  });
  final AccountEntity? accountEntity;
  final String? patientId;
}

class GetPatientInforEvent extends PatientEvent {
  final String patientId;
  GetPatientInforEvent({required this.patientId}) : super();
}
