part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  LoginUserEvent({this.username, this.password});
  final String? username;
  final String? password;
}

// class GetPatientInforInPatientAppEvent extends LoginEvent {
//   final String id;
//  GetPatientInforInPatientAppEvent({required this.id}) : super();
// }