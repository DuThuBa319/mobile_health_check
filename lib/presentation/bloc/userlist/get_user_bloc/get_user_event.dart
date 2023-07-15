part of 'get_user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetListUserEvent extends UserEvent {
  GetListUserEvent();
}

class FilterUserEvent extends UserEvent {
  FilterUserEvent({required this.searchText});
  final String searchText;
}

class RegistUserEvent extends UserEvent {
  RegistUserEvent({required this.user});
  final UserModel user;
}
// class FilterUserEvent extends UserEvent {
//   FilterUserEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



