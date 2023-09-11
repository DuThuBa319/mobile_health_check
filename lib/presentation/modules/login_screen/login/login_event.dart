part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  LoginUserEvent({this.username, this.password});
  final String? username;
  final String? password;
  
}

class GetUserDataEvent extends LoginEvent {
  final String? doctorId;

  GetUserDataEvent({this.doctorId});
}

// class GetUnreadCountNotificationEvent extends LoginEvent {
//   GetUnreadCountNotificationEvent({this.doctorId});
//   final String? doctorId;
// }
