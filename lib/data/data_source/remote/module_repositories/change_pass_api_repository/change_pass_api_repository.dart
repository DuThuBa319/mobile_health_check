import 'package:mobile_health_check/data/models/change_password_model/change_password_model.dart';

abstract class ChangePassApiRepository {
  Future<void> changePassModel(
      String? userId, ChangePassModel? changePassModel);
}
