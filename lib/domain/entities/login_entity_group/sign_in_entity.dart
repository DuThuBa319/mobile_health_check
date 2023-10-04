
import 'package:mobile_health_check/domain/entities/login_entity_group/token_entity.dart';

import 'account_entity.dart';

class SignInEntity {
  TokenEntity? token;

  AccountEntity? accountInfor;

  List<String?>? roles;

  SignInEntity({this.accountInfor, this.roles, this.token});
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity  