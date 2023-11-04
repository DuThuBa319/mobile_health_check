//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/reset_password_api_repository/reset_password_api_repository.dart';
part 'reset_password_repository.impl.dart';

abstract class ResetPasswordRepository {
  Future<void> resetPasswordModel({String? userId});
}
