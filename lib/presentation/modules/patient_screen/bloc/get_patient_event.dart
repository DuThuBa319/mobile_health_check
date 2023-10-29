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

// class GetPatientListOfRelativeEvent extends PatientEvent {
//   // GetPatientListEvent();
//   final String relativeId;
//   GetPatientListOfRelativeEvent({required this.relativeId}) : super();
// }

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

// class UpdatePatientInforEvent extends PatientEvent {
//   final String? id;
//   final PatientInforEntity patientInforEntity;
//   UpdatePatientInforEvent({required this.patientInforEntity, required this.id})
//       : super();
// }

// class ChangePassEvent extends PatientEvent {
//   final String? userId;
//   final ChangePassEntity changePassEntity;
//   ChangePassEvent({required this.changePassEntity, required this.userId})
//       : super();
// }

// class UpdateRelativeInforEvent extends PatientEvent {
//   final String? id;
//   final RelativeInforEntity relativeInforEntity;
//   UpdateRelativeInforEvent(
//       {required this.relativeInforEntity, required this.id})
//       : super();
// }

// class UpdateDoctorInforEvent extends PatientEvent {
//   final String? id;
//   final DoctorInforEntity doctorInforEntity;
//   UpdateDoctorInforEvent({required this.doctorInforEntity, required this.id})
//       : super();
// }
