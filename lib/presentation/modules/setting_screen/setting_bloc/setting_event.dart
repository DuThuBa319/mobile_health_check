part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class GetDoctorListEvent extends SettingEvent {
  GetDoctorListEvent() : super();
}









class UpdatePatientInforEvent extends SettingEvent {
  final String? id;
  final PatientInforEntity patientInforEntity;
  UpdatePatientInforEvent({required this.patientInforEntity, required this.id})
      : super();
}

class ChangePassEvent extends SettingEvent {
  final String? userId;
  final ChangePassEntity changePassEntity;
  ChangePassEvent({required this.changePassEntity, required this.userId})
      : super();
}

class UpdateRelativeInforEvent extends SettingEvent {
  final String? id;
  final RelativeInforEntity relativeInforEntity;
  UpdateRelativeInforEvent(
      {required this.relativeInforEntity, required this.id})
      : super();
}

class UpdateDoctorInforEvent extends SettingEvent {
  final String? id;
  final DoctorInforEntity doctorInforEntity;
  UpdateDoctorInforEvent({required this.doctorInforEntity, required this.id})
      : super();
}
