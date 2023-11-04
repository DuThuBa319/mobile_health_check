import 'package:injectable/injectable.dart';

import '../../repositories/reset_password_repository/reset_password_repository.dart';

part 'reset_password_usecase.impl.dart';

abstract class ResetPasswordUsecase {
  Future<void> resetPasswordEntity({String? userId});
}

//Reppo chứa dữ liệu là list RelativeInformodel thì usecase chứa list RelativeInforentity