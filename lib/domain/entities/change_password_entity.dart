import '../../data/models/change_password_model/change_password_model.dart';

class ChangePassEntity {
  String? newPassword;
  String? currentPassword;
  ChangePassEntity({this.newPassword, this.currentPassword});

  ChangePassModel get convertToChangePassModel {
    return ChangePassModel(
        currentPassword: currentPassword, newPassword: newPassword);
  }
}
