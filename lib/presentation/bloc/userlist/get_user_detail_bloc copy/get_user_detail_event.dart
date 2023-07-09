import 'package:flutter/cupertino.dart';

import '../../../../data/models/user_model.dart';

@immutable
abstract class UserDetailEvent {}

class GetUserDetailEvent extends UserDetailEvent {
  final int userId;

  GetUserDetailEvent({required this.userId}) : super();
}

class DeleteUserEvent extends UserDetailEvent {
  final int userId;

  DeleteUserEvent({required this.userId}) : super();
}

class UpdateUserEvent extends UserDetailEvent {
  final int userId;
  final UserModel user;

   UpdateUserEvent({required this.userId,required this.user}) : super();
}


// class FilterUserEvent extends UserEvent {
//   FilterUserEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



