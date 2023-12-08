part of 'admin_bloc.dart';

@immutable
abstract class GetDoctorEvent {}

class GetDoctorListEvent extends GetDoctorEvent {
  GetDoctorListEvent() : super();
}

class FilterDoctorEvent extends GetDoctorEvent {
  FilterDoctorEvent({required this.searchText, required this.id});
  final String searchText;
  final String id;
}

class DeleteDoctorEvent extends GetDoctorEvent {
  DeleteDoctorEvent({required this.doctorId});
  final String? doctorId;
}

class GetDoctorInforEvent extends GetDoctorEvent {
  final String? doctorId;
  GetDoctorInforEvent({required this.doctorId}) : super();
}


class RegistDoctorEvent extends GetDoctorEvent {
  final AccountEntity? accountEntity;
  RegistDoctorEvent({required this.accountEntity}) : super();
}



