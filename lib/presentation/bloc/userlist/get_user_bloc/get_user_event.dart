import 'package:flutter/cupertino.dart';

import '../../../../data/models/user_model.dart';

@immutable
abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  GetUserEvent();
}

class FilterUserEvent extends UserEvent {
  FilterUserEvent({required this.searchText});
  String searchText;
}

class RegistUserEvent extends UserEvent {
  RegistUserEvent({required this.user});
  UserModel user;
}
// class FilterUserEvent extends UserEvent {
//   FilterUserEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



