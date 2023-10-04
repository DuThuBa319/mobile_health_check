import 'package:injectable/injectable.dart';


import '../../entities/login_entity_group/authentication_entity.dart';
import '../../entities/login_entity_group/sign_in_entity.dart';
import '../../repositories/authentication_repository/authentication_repository.dart';

part 'authentication_usecase.impl.dart';

abstract class AuthenUsecase {
  Future<SignInEntity> signInAuthenEntity(AuthenEntity? authenEntity);
}

//Reppo chứa dữ liệu là list RelativeInformodel thì usecase chứa list RelativeInforentity