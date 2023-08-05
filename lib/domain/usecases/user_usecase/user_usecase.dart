import 'package:common_project/data/models/user_model.dart';
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/user_api_repository/user_api_repository.dart';

part 'user_usecase.impl.dart';

abstract class UserUsecase {
  Future<List<UserEntity>?> getListUserEntity();
  Future<UserEntity> addUserEntity(UserModel user);
}

//Reppo chứa dữ liệu là list usermodel thì usecase chứa list userentity