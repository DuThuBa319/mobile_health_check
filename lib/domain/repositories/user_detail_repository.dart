import 'package:injectable/injectable.dart';
import 'package:common_project/data/data_source/remote/module_repositories/user_api_detail_repository.dart';
import 'package:common_project/data/models/user_model.dart';

import 'user_detail_repository.impl.dart';

abstract class UserDetailModelRepository {
  Future<UserModel> getUserModel(int id);
}
