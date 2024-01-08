// ignore_for_file: must_be_immutable

part of 'admin_bloc.dart';

@immutable
abstract class GetDoctorEvent {}

class GetDoctorListEvent extends GetDoctorEvent {
  GetDoctorListEvent({required this.admindId});
  String admindId;
}

class FilterDoctorEvent extends GetDoctorEvent {
  FilterDoctorEvent({required this.searchText, required this.adminId});
  final String searchText;
  final String adminId;
}

class DeleteDoctorEvent extends GetDoctorEvent {
  DeleteDoctorEvent({required this.doctorId, required this.adminId});
  final String? doctorId;
  final String? adminId;
}

class GetDoctorInforEvent extends GetDoctorEvent {
  final String? doctorId;
  GetDoctorInforEvent({required this.doctorId});
}

class RegistDoctorEvent extends GetDoctorEvent {
  final AccountEntity? accountEntity;
  RegistDoctorEvent({required this.accountEntity});
}
