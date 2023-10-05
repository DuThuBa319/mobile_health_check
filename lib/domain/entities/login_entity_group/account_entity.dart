import 'package:mobile_health_check/data/models/account_model/account_model.dart';

class AccountEntity {
  String? name;
  String? phoneNumber;
  AccountEntity({this.name, this.phoneNumber});

  AccountModel get convertToAccountModel {
    return AccountModel(name: name, phoneNumber: phoneNumber);
  }
}
