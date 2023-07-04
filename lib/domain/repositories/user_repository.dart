import 'package:common_project/data/data_source/remote/module_repositories/user_api_repository.dart';
import 'package:common_project/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

part 'user_repository.impl.dart';

abstract class LoginRepository {
  Future<List<UserModel>?> getListUserModels();
}
