import 'package:injectable/injectable.dart';

import '../../entities/change_password_entity.dart';
import '../../repositories/change_pass_repository/change_pass_repository.dart';

part 'change_pass_usecase.impl.dart';

abstract class ChangePassUsecase {
  Future<void> changePassEntity(
      ChangePassEntity? changePassEntity, String? userId);
}

//Reppo chứa dữ liệu là list RelativeInformodel thì usecase chứa list RelativeInforentity