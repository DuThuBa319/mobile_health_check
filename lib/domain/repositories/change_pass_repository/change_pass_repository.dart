//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/change_pass_api_repository/change_pass_api_repository.dart';
import '../../../data/models/change_password_model/change_password_model.dart';
part 'change_pass_repository.impl.dart';

abstract class ChangePassRepository {
  Future<void> changePassModel(
      ChangePassModel? changePassModel, String? userId);
}
