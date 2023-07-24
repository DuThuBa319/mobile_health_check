import 'package:injectable/injectable.dart';
import 'package:common_project/data/data_source/remote/module_repositories/user_api_detail_repository.dart';
import 'package:common_project/data/models/user_model.dart';
import 'user_detail_repository.dart';

@Injectable(as: UserDetailModelRepository)
class UserDetailRepositoryImpl extends UserDetailModelRepository {
  final UserDetailRepository _userApi;

  UserDetailRepositoryImpl(this._userApi);

  @override
  Future<UserModel> getUserModel(int id) {
    return _userApi.getUserModel(id);
  }
}
