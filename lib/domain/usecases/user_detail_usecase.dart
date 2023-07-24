import 'package:common_project/data/models/user_model.dart';
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_source/remote/module_repositories/user_api_detail_repository.dart';
part 'user_detail_usecase.impl.dart';

abstract class UserDetailUsecase {
  Future<UserEntity> getUserDetailEntity(int id);
  Future<void> deleteUserEntity(int id);
  Future<void> updateUserEntity(int id, UserModel user);
}

//Reppo chứa dữ liệu là list usermodel thì usecase chứa list userentity