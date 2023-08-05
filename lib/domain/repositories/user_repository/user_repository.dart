import 'package:injectable/injectable.dart';

import 'package:common_project/data/models/user_model.dart';

import '../../../data/data_source/remote/module_repositories/user_api_repository/user_api_repository.dart';

part 'user_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class UserListRepository {
  Future<List<UserModel>?> getListUserModels();
  Future<UserModel> AddUserModel(UserModel user);
}
