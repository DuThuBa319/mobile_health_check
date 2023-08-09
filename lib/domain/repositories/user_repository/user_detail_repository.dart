import 'package:mobile_health_check/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../../data/data_source/remote/module_repositories/user_api_repository/user_api_detail_repository.dart';
part 'user_detail_repository.impl.dart';

abstract class UserDetailModelRepository {
  Future<UserModel> getUserModel(int id);
}
